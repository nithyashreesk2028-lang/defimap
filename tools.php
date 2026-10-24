<?php
require __DIR__ . DIRECTORY_SEPARATOR . 'bootstrap.php';

if (!isset($_SESSION['user_id'])) {
    $requestedSection = (string)($_GET['section'] ?? 'molecular');
    $allowedSections = ['molecular', 'nutrition', 'reference', 'resources', 'search', 'settings'];
    $loginSection = in_array($requestedSection, $allowedSections, true) ? $requestedSection : 'molecular';
    header("Location: index.php?return=" . rawurlencode('tools.php?section=' . $loginSection));
    exit();
}

$sections = [
    'molecular' => 'Genes, Proteins & Pathways',
    'nutrition' => 'Foods & Nutrients',
    'reference' => 'Deficiency & Symptom Guide',
    'resources' => 'Scientific Sources',
    'search' => 'Knowledge Base Search',
    'settings' => 'Account Settings',
];
$knowledgeSections = array_diff_key($sections, ['search' => true, 'settings' => true]);
$section = (string)($_GET['section'] ?? 'molecular');
if (!isset($sections[$section])) {
    http_response_code(404);
    exit('Section not found.');
}
$searchQuery = substr(trim((string)($_GET['q'] ?? '')), 0, 120);
$globalSearchResults = [];

$userId = (int)$_SESSION['user_id'];
$userStmt = $pdo->prepare("SELECT name, email, password FROM users WHERE id=?");
$userStmt->execute([$userId]);
$user = $userStmt->fetch(PDO::FETCH_ASSOC);
if (!$user) {
    session_destroy();
    header("Location: index.php");
    exit();
}

if ($section === 'search' && $searchQuery !== '') {
    $like = '%' . $searchQuery . '%';
    $searchQueries = [
        [
            'query' => "SELECT 'Deficiency' AS category, d.deficiency_name AS title,
                    CONCAT_WS(' · ', NULLIF(d.description, ''), NULLIF(dm.related_nutrient, '')) AS detail,
                    dm.source_url, 'reference' AS target
                FROM deficiency_master d
                LEFT JOIN deficiency_metadata dm ON dm.deficiency_id=d.deficiency_id
                WHERE d.deficiency_name LIKE ? OR d.description LIKE ? OR d.cause LIKE ? OR dm.related_nutrient LIKE ?
                ORDER BY d.deficiency_name LIMIT 10",
            'parameters' => array_fill(0, 4, $like),
        ],
        [
            'query' => "SELECT 'Symptom' AS category, s.symptom_name AS title,
                    sm.description AS detail, sm.source_url, 'reference' AS target
                FROM symptom_master s
                LEFT JOIN symptom_metadata sm ON sm.symptom_id=s.symptom_id
                WHERE s.symptom_name LIKE ? OR sm.description LIKE ?
                ORDER BY s.symptom_name LIMIT 10",
            'parameters' => array_fill(0, 2, $like),
        ],
        [
            'query' => "SELECT 'Gene' AS category, CONCAT(g.gene_symbol, ' — ', g.gene_name) AS title,
                    CONCAT_WS(' · ', d.deficiency_name, gm.association_description, CONCAT('NCBI Gene ID ', g.ncbi_gene_id)) AS detail,
                    gm.source_url, 'molecular' AS target
                FROM gene_associations g
                JOIN deficiency_master d ON d.deficiency_id=g.deficiency_id
                LEFT JOIN gene_association_metadata gm ON gm.association_id=g.id
                WHERE g.gene_symbol LIKE ? OR g.gene_name LIKE ? OR g.ncbi_gene_id LIKE ? OR d.deficiency_name LIKE ? OR gm.association_description LIKE ?
                ORDER BY g.gene_symbol LIMIT 10",
            'parameters' => array_fill(0, 5, $like),
        ],
        [
            'query' => "SELECT 'Protein' AS category, p.protein_name AS title,
                    CONCAT_WS(' · ', d.deficiency_name, p.uniprot_accession, pm.protein_function, pm.association_description) AS detail,
                    pm.source_url, 'molecular' AS target
                FROM protein_associations p
                JOIN deficiency_master d ON d.deficiency_id=p.deficiency_id
                LEFT JOIN protein_association_metadata pm ON pm.association_id=p.id
                WHERE p.protein_name LIKE ? OR p.uniprot_accession LIKE ? OR d.deficiency_name LIKE ? OR pm.protein_function LIKE ? OR pm.association_description LIKE ?
                ORDER BY p.protein_name LIMIT 10",
            'parameters' => array_fill(0, 5, $like),
        ],
        [
            'query' => "SELECT 'Pathway' AS category, p.pathway_name AS title,
                    CONCAT_WS(' · ', d.deficiency_name, pm.pathway_id, pm.pathway_description) AS detail,
                    pm.source_url, 'molecular' AS target
                FROM pathway_associations p
                JOIN deficiency_master d ON d.deficiency_id=p.deficiency_id
                LEFT JOIN pathway_association_metadata pm ON pm.association_id=p.id
                WHERE p.pathway_name LIKE ? OR pm.pathway_id LIKE ? OR pm.pathway_description LIKE ? OR d.deficiency_name LIKE ?
                ORDER BY p.pathway_name LIMIT 10",
            'parameters' => array_fill(0, 4, $like),
        ],
        [
            'query' => "SELECT 'Food recommendation' AS category, f.food_name AS title,
                    CONCAT_WS(' · ', d.deficiency_name, fm.nutrient_name, f.benefits, f.avoid_food) AS detail,
                    fm.source_url, 'nutrition' AS target
                FROM food_recommendations f
                JOIN deficiency_master d ON d.deficiency_id=f.deficiency_id
                LEFT JOIN food_recommendation_metadata fm ON fm.food_recommendation_id=f.id
                WHERE f.food_name LIKE ? OR f.benefits LIKE ? OR f.avoid_food LIKE ? OR d.deficiency_name LIKE ? OR fm.nutrient_name LIKE ?
                ORDER BY f.food_name LIMIT 10",
            'parameters' => array_fill(0, 5, $like),
        ],
        [
            'query' => "SELECT 'USDA food composition' AS category, food_name AS title,
                    CONCAT_WS(' · ', nutrient_name, CONCAT(nutrient_amount, ' ', nutrient_unit), serving_basis, CONCAT('FDC ID ', fdc_id), verification_status) AS detail,
                    source_url, 'nutrition' AS target
                FROM food_nutrient_data
                WHERE food_name LIKE ? OR nutrient_name LIKE ? OR fdc_id LIKE ? OR verification_status LIKE ?
                ORDER BY food_name LIMIT 10",
            'parameters' => array_fill(0, 4, $like),
        ],
        [
            'query' => "SELECT 'Nutrient compound' AS category, compound_name AS title,
                    CONCAT_WS(' · ', related_nutrient, molecular_formula, CONCAT('PubChem CID ', pubchem_cid), verification_status) AS detail,
                    source_url, 'nutrition' AS target
                FROM compound_data
                WHERE compound_name LIKE ? OR related_nutrient LIKE ? OR molecular_formula LIKE ? OR pubchem_cid LIKE ?
                ORDER BY compound_name LIMIT 10",
            'parameters' => array_fill(0, 4, $like),
        ],
        [
            'query' => "SELECT 'Scientific source' AS category, dataset_name AS title,
                    CONCAT_WS(' · ', organization, record_identifier, verification_status) AS detail,
                    source_url, 'resources' AS target
                FROM dataset_sources
                WHERE dataset_name LIKE ? OR organization LIKE ? OR record_identifier LIKE ? OR verification_status LIKE ?
                ORDER BY dataset_name LIMIT 10",
            'parameters' => array_fill(0, 4, $like),
        ],
    ];

    foreach ($searchQueries as $searchSpecification) {
        $searchStmt = $pdo->prepare($searchSpecification['query']);
        $searchStmt->execute($searchSpecification['parameters']);
        array_push($globalSearchResults, ...$searchStmt->fetchAll(PDO::FETCH_ASSOC));
    }
}

$settingsMessage = '';
$settingsError = false;
if ($section === 'settings') {
    if (empty($_SESSION['settings_csrf'])) {
        $_SESSION['settings_csrf'] = bin2hex(random_bytes(32));
    }

    if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'POST') {
        $name = trim((string)($_POST['name'] ?? ''));
        $email = trim((string)($_POST['email'] ?? ''));
        $currentPassword = (string)($_POST['current_password'] ?? '');
        $newPassword = (string)($_POST['new_password'] ?? '');
        $confirmPassword = (string)($_POST['confirm_password'] ?? '');
        $csrfToken = (string)($_POST['csrf_token'] ?? '');

        if (!hash_equals($_SESSION['settings_csrf'], $csrfToken)) {
            http_response_code(403);
            $settingsMessage = 'Your session token is invalid. Refresh the page and try again.';
            $settingsError = true;
        } elseif ($name === '' || strlen($name) > 100 || !filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 100) {
            $settingsMessage = 'Enter a name of up to 100 characters and a valid email address of up to 100 characters.';
            $settingsError = true;
        } elseif (!password_verify($currentPassword, $user['password'])) {
            $settingsMessage = 'Enter your current password to save account changes.';
            $settingsError = true;
        } elseif (($newPassword !== '' || $confirmPassword !== '') && (strlen($newPassword) < 8 || $newPassword !== $confirmPassword)) {
            $settingsMessage = $newPassword !== $confirmPassword
                ? 'The new password and confirmation do not match.'
                : 'The new password must be at least 8 characters long.';
            $settingsError = true;
        } else {
            $emailStmt = $pdo->prepare("SELECT id FROM users WHERE email=? AND id<>?");
            $emailStmt->execute([$email, $userId]);
            if ($emailStmt->fetchColumn()) {
                $settingsMessage = 'That email address is already in use.';
                $settingsError = true;
            } else {
                if ($newPassword !== '') {
                    $passwordHash = password_hash($newPassword, PASSWORD_DEFAULT);
                    $updateStmt = $pdo->prepare("UPDATE users SET name=?, email=?, password=? WHERE id=?");
                    $updateStmt->execute([$name, $email, $passwordHash, $userId]);
                    $user['password'] = $passwordHash;
                    session_regenerate_id(true);
                } else {
                    $updateStmt = $pdo->prepare("UPDATE users SET name=?, email=? WHERE id=?");
                    $updateStmt->execute([$name, $email, $userId]);
                }

                $_SESSION['user_name'] = $name;
                $user['name'] = $name;
                $user['email'] = $email;
                $settingsMessage = 'Account settings saved.';
                $_SESSION['settings_csrf'] = bin2hex(random_bytes(32));
            }
        }
    }
}

$genes = [];
$proteins = [];
$pathways = [];
$foods = [];
$deficiencyRecords = [];
$symptomMappings = [];
$datasetSources = [];
if ($section === 'molecular') {
    $genes = $pdo->query("SELECT d.deficiency_name, g.gene_symbol, g.gene_name, g.ncbi_gene_id,
            gm.association_description, gm.source_url
        FROM gene_associations g
        JOIN deficiency_master d ON d.deficiency_id=g.deficiency_id
        LEFT JOIN gene_association_metadata gm ON gm.association_id=g.id
        ORDER BY d.deficiency_name, g.gene_symbol")->fetchAll(PDO::FETCH_ASSOC);
    $proteins = $pdo->query("SELECT d.deficiency_name, p.protein_name, p.uniprot_accession,
            pm.protein_function, pm.association_description, pm.source_url
        FROM protein_associations p
        JOIN deficiency_master d ON d.deficiency_id=p.deficiency_id
        LEFT JOIN protein_association_metadata pm ON pm.association_id=p.id
        ORDER BY d.deficiency_name, p.protein_name")->fetchAll(PDO::FETCH_ASSOC);
    $pathways = $pdo->query("SELECT d.deficiency_name, p.pathway_name,
            pm.pathway_id, pm.pathway_description, pm.source_url
        FROM pathway_associations p
        JOIN deficiency_master d ON d.deficiency_id=p.deficiency_id
        LEFT JOIN pathway_association_metadata pm ON pm.association_id=p.id
        ORDER BY d.deficiency_name, p.pathway_name")->fetchAll(PDO::FETCH_ASSOC);
} elseif ($section === 'nutrition') {
    $foods = $pdo->query("SELECT d.deficiency_name, f.food_name, f.benefits, f.avoid_food,
            fm.nutrient_name, fm.source_url
        FROM food_recommendations f
        JOIN deficiency_master d ON d.deficiency_id=f.deficiency_id
        LEFT JOIN food_recommendation_metadata fm ON fm.food_recommendation_id=f.id
        ORDER BY d.deficiency_name, f.food_name")->fetchAll(PDO::FETCH_ASSOC);
    $foodNutrientData = $pdo->query("SELECT food_name, fdc_id, nutrient_name,
            nutrient_amount, nutrient_unit, serving_basis, source_url, verification_status
        FROM food_nutrient_data
        ORDER BY food_name, nutrient_name")->fetchAll(PDO::FETCH_ASSOC);
} elseif ($section === 'reference') {
    $deficiencyRecords = $pdo->query("SELECT d.deficiency_id, d.deficiency_name, d.description,
            d.cause, dm.related_nutrient, dm.source_url
        FROM deficiency_master d
        LEFT JOIN deficiency_metadata dm ON dm.deficiency_id=d.deficiency_id
        ORDER BY d.deficiency_name")->fetchAll(PDO::FETCH_ASSOC);
    $symptomMappings = $pdo->query("SELECT d.deficiency_name, d.deficiency_id,
            s.symptom_name, sm.description AS symptom_description,
            ds.weight, dm.evidence_note, dm.source_url
        FROM deficiency_symptoms ds
        JOIN deficiency_master d ON d.deficiency_id=ds.deficiency_id
        JOIN symptom_master s ON s.symptom_id=ds.symptom_id
        LEFT JOIN symptom_metadata sm ON sm.symptom_id=s.symptom_id
        LEFT JOIN deficiency_symptom_metadata dm
            ON dm.deficiency_id=ds.deficiency_id AND dm.symptom_id=ds.symptom_id
        ORDER BY d.deficiency_name, s.symptom_name")->fetchAll(PDO::FETCH_ASSOC);
} elseif ($section === 'resources') {
    $datasetSources = $pdo->query("SELECT dataset_name, organization, source_url,
            record_identifier, version_or_release, access_date, license, verification_status
        FROM dataset_sources
        ORDER BY organization, dataset_name, source_id")->fetchAll(PDO::FETCH_ASSOC);
}

$resources = [
    ['NCBI Gene', 'Gene records, names, and identifiers from the National Center for Biotechnology Information.', 'https://www.ncbi.nlm.nih.gov/gene/'],
    ['UniProt', 'Protein sequences and functional information from the UniProt Knowledgebase.', 'https://www.uniprot.org/'],
    ['Reactome', 'Curated biological pathways and reactions.', 'https://reactome.org/'],
    ['NIH Office of Dietary Supplements', 'Fact sheets on vitamins, minerals, and dietary supplements.', 'https://ods.od.nih.gov/factsheets/list-all/'],
    ['MedlinePlus: Nutrition', 'Consumer-friendly nutrition information from the U.S. National Library of Medicine.', 'https://medlineplus.gov/nutrition.html'],
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($sections[$section]); ?> | DefiMap</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        :root { --navy: #0B1F3A; --primary: #1456A0; --action: #1677E8; --pale: #F3F7FC; --text: #183153; --muted: #64748B; --border: #DCE7F3; --shadow: 0 18px 40px rgba(11, 31, 58, 0.08); }
        * { box-sizing: border-box; }
        body { margin: 0; font-family: "Segoe UI", Arial, sans-serif; background: var(--pale); color: var(--text); }
        a { text-decoration: none; }
        .app-shell { display: flex; min-height: 100vh; }
        .sidebar { width: 240px; background: linear-gradient(180deg, #0B1F3A 0%, #0D2342 100%); color: #fff; padding: 22px 18px 18px; position: sticky; top: 0; height: 100vh; display: flex; flex-direction: column; }
        .brand-box { display: flex; align-items: center; gap: 12px; padding: 8px 10px 18px; border-bottom: 1px solid rgba(255,255,255,.08); margin-bottom: 18px; }
        .brand-icon { width: 44px; height: 44px; border-radius: 14px; display: grid; place-items: center; background: rgba(255,255,255,.08); }
        .brand-box h1 { margin: 0; font-size: 1.8rem; letter-spacing: -.05em; }
        .brand-box small { display: block; color: rgba(255,255,255,.7); letter-spacing: .08em; text-transform: uppercase; font-size: .62rem; }
        .nav-group { display: grid; gap: 8px; }
        .sidebar-nav { min-height: 0; overflow-y: auto; }
        .nav-group + .nav-group { padding-top: 10px; margin-top: 10px; border-top: 1px solid rgba(255,255,255,.08); }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px; border-radius: 12px; color: rgba(255,255,255,.82); font-weight: 600; }
        .nav-item:hover, .nav-item:focus-visible, .nav-item.active { background: rgba(22,119,232,.18); color: #fff; outline: none; }
        .sidebar-footer { margin-top: auto; padding: 16px 12px 10px; border-top: 1px solid rgba(255,255,255,.08); text-align: center; color: rgba(255,255,255,.8); font-size: .82rem; }
        .sidebar-meta { text-align: center; color: rgba(255,255,255,.58); font-size: .72rem; }
        .content { flex: 1; min-width: 0; }
        .topbar { background: rgba(255,255,255,.9); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 2; }
        .topbar-inner { max-width: 1320px; margin: 0 auto; padding: 18px 28px; display: flex; align-items: center; justify-content: space-between; gap: 18px; }
        .topbar-tools { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
        .topbar-tools .search-box { width: min(420px, 42vw); margin-bottom: 0; }
        .topbar-tools .search-box button { border: 0; background: transparent; color: var(--primary); cursor: pointer; }
        .page-context { color: var(--muted); font-weight: 600; }
        .page-context strong { color: var(--navy); }
        .profile { color: var(--navy); font-weight: 600; }
        .logout-link { margin-left: 16px; color: var(--navy); font-weight: 600; }
        .page-shell { max-width: 1320px; margin: 0 auto; padding: 30px 28px 42px; }
        .welcome-card { background: linear-gradient(135deg, #0b3d91, #1a68d1); color: #fff; border-radius: 22px; padding: 26px 30px; box-shadow: var(--shadow); margin-bottom: 22px; }
        .welcome-card h2 { margin: 0 0 8px; }
        .welcome-card p { margin: 0; color: rgba(255,255,255,.84); }
        .section-nav { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 20px; }
        .section-nav a { background: #fff; border: 1px solid var(--border); border-radius: 12px; padding: 11px 14px; color: var(--navy); font-weight: 700; }
        .section-nav a.active { background: rgba(20,86,160,.1); border-color: rgba(20,86,160,.3); color: var(--primary); }
        .panel { background: #fff; border: 1px solid var(--border); border-radius: 18px; box-shadow: var(--shadow); padding: 22px; margin-bottom: 18px; }
        .panel h3 { margin: 0 0 16px; color: var(--navy); font-size: 1.2rem; }
        .search-box { display: flex; gap: 10px; align-items: center; padding: 10px 14px; border: 1px solid var(--border); border-radius: 12px; background: #fbfdff; margin-bottom: 16px; }
        .search-box input { border: 0; outline: 0; background: transparent; width: 100%; color: var(--text); }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { text-align: left; vertical-align: top; padding: 12px 10px; border-bottom: 1px solid var(--border); }
        .data-table th { color: var(--muted); font-size: .78rem; text-transform: uppercase; letter-spacing: .05em; }
        .data-table tr:last-child td { border-bottom: 0; }
        .data-table a, .resource-card a { color: var(--primary); font-weight: 700; }
        .table-pagination { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; margin-top: 12px; color: var(--muted); font-size: .9rem; }
        .table-pagination button { border: 1px solid var(--border); border-radius: 8px; padding: 7px 11px; background: #fff; color: var(--primary); font: inherit; font-weight: 700; cursor: pointer; }
        .table-pagination button:disabled { opacity: .5; cursor: not-allowed; }
        .search-status { margin: -6px 0 14px; color: var(--muted); font-size: .9rem; }
        .resource-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 14px; }
        .resource-card { border: 1px solid var(--border); border-radius: 14px; padding: 18px; }
        .resource-card h4 { color: var(--navy); font-size: 1.05rem; }
        .resource-card p { color: var(--muted); }
        .form-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; }
        .field-block { display: flex; flex-direction: column; gap: 7px; }
        .field-block label { color: var(--navy); font-weight: 600; }
        .field-block input { width: 100%; border: 1px solid var(--border); border-radius: 10px; padding: 11px 12px; }
        .full-width { grid-column: 1 / -1; }
        .form-actions { margin-top: 18px; }
        .save-button { border: 0; border-radius: 10px; background: var(--primary); color: #fff; font-weight: 700; padding: 12px 18px; }
        .empty-state { padding: 16px; background: #f7faff; border-radius: 12px; color: var(--muted); }
        @media (max-width: 1000px) { .app-shell { display: block; } .sidebar { width: 100%; height: auto; position: static; } .resource-grid { grid-template-columns: 1fr; } }
        @media (max-width: 700px) { .topbar-inner, .page-shell { padding-left: 16px; padding-right: 16px; } .topbar-inner { align-items: flex-start; flex-direction: column; } .form-grid { grid-template-columns: 1fr; } .full-width { grid-column: auto; } .table-wrap { overflow-x: auto; } .data-table { min-width: 650px; } }
    </style>
    <?php defimap_theme_head(); ?>
</head>
<body>
    <div class="app-shell">
        <aside class="sidebar" aria-label="Sidebar navigation">
            <div class="brand-box">
                <div class="brand-icon"><i class="fa-solid fa-dna"></i></div>
                <div><h1>DefiMap</h1><small>Nutrition · Genes · Health</small></div>
            </div>
            <nav class="sidebar-nav" aria-label="Sidebar navigation">
            <div class="nav-group">
                <p class="nav-section-label">Workspace</p>
                <a class="nav-item" href="dashboard.php"><i class="fa-solid fa-house"></i> Home</a>
                <a class="nav-item" href="analysis.php"><i class="fa-solid fa-microscope"></i> Start an Assessment</a>
                <a class="nav-item" href="reports.php"><i class="fa-solid fa-clock-rotate-left"></i> Reports &amp; History</a>
                <a class="nav-item" href="dashboard.php#saved"><i class="fa-solid fa-bookmark"></i> Saved Cases</a>
                <a class="nav-item <?php echo $section === 'settings' ? 'active' : ''; ?>" href="tools.php?section=settings"><i class="fa-solid fa-gear"></i> Account Settings</a>
            </div>
            <div class="nav-group">
                <p class="nav-section-label">Knowledge base</p>
                <?php foreach ($knowledgeSections as $key => $label): ?>
                    <a class="nav-item <?php echo $section === $key ? 'active' : ''; ?>" href="tools.php?section=<?php echo urlencode($key); ?>">
                        <i class="fa-solid <?php echo $key === 'molecular' ? 'fa-magnifying-glass' : ($key === 'nutrition' ? 'fa-utensils' : ($key === 'reference' ? 'fa-book-medical' : 'fa-book-open')); ?>"></i>
                        <?php echo htmlspecialchars($label); ?>
                    </a>
                <?php endforeach; ?>
            </div>
            </nav>
            <div class="sidebar-account">
                <div class="sidebar-account-avatar"><?php echo htmlspecialchars(strtoupper(substr($user['name'], 0, 1))); ?></div>
                <div class="sidebar-account-copy"><strong><?php echo htmlspecialchars($user['name']); ?></strong><span>Research account</span></div>
            </div>
            <div class="sidebar-footer">Evidence-guided nutrition research</div>
        </aside>
        <main class="content">
            <header class="topbar">
                <div class="topbar-inner">
                    <div class="page-context"><strong><?php echo htmlspecialchars($sections[$section]); ?></strong> / DefiMap library</div>
                    <div class="topbar-tools">
                        <form class="search-box" method="get" action="tools.php" role="search" aria-label="Search the knowledge base">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="hidden" name="section" value="search">
                            <input type="search" name="q" value="<?php echo htmlspecialchars($searchQuery); ?>" placeholder="Search foods, nutrients, genes…" aria-label="Search foods, nutrients, genes, proteins and pathways">
                            <button type="submit" aria-label="Submit knowledge-base search"><i class="fa-solid fa-arrow-right"></i></button>
                        </form>
                        <span class="profile"><?php echo htmlspecialchars($user['name']); ?></span><form class="logout-form" method="post" action="logout.php"><input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars(defimap_csrf_token(), ENT_QUOTES, 'UTF-8'); ?>"><button class="logout-link" type="submit"><i class="fa-solid fa-right-from-bracket"></i> Logout</button></form><?php defimap_theme_control(); ?>
                    </div>
                </div>
            </header>
            <div class="page-shell">
                <section class="welcome-card">
                    <h2><?php echo htmlspecialchars($sections[$section]); ?></h2>
                    <p>
                        <?php if ($section === 'molecular'): ?>Explore genes, proteins, and biological pathway context linked to deficiency categories. These associations provide research context, not proof of cause; Reactome pathway identifiers remain unresolved where shown.
                        <?php elseif ($section === 'nutrition'): ?>Browse food recommendations and nutrient measurements. The USDA measurements refer to specific source records and are not automatically matched to every recommended food.
                        <?php elseif ($section === 'reference'): ?>Read educational deficiency summaries and symptom associations. Symptoms are nonspecific, and project weights are not probabilities or diagnostic scores.
                        <?php elseif ($section === 'resources'): ?>Find source organizations and external references for further reading. A source link does not mean every related claim has been independently verified.
                        <?php else: ?>Manage your account name, email address, and password.
                        <?php endif; ?>
                    </p>
                </section>
                <nav class="section-nav" aria-label="Library sections">
                    <?php foreach ($knowledgeSections as $key => $label): ?>
                        <a class="<?php echo $section === $key ? 'active' : ''; ?>" href="tools.php?section=<?php echo urlencode($key); ?>"><?php echo htmlspecialchars($label); ?></a>
                    <?php endforeach; ?>
                </nav>
                <div class="alert alert-info" role="note">
                    <strong>Knowledge base = reference library.</strong> Use it to look up background information; it does not replace or remove your assessments. Return to <a href="reports.php">Workspace reports and saved cases</a> whenever you need to reopen a report.
                </div>

                <?php if ($section === 'search'): ?>
                    <section class="panel">
                        <h3>Search the knowledge base</h3>
                        <?php if ($searchQuery === ''): ?>
                            <p>Enter a food, nutrient, symptom, deficiency, gene symbol or ID, protein accession, pathway, or source organization in the search bar above.</p>
                        <?php else: ?>
                            <p><?php echo count($globalSearchResults); ?> result<?php echo count($globalSearchResults) === 1 ? '' : 's'; ?> for <strong><?php echo htmlspecialchars($searchQuery); ?></strong>. These records are for educational reference; source links and associations do not establish a diagnosis.</p>
                            <?php if ($globalSearchResults): ?>
                                <div class="table-wrap"><table class="data-table">
                                    <thead><tr><th>Type</th><th>Record</th><th>Details</th><th>Open</th><th>Source</th></tr></thead>
                                    <tbody>
                                        <?php foreach ($globalSearchResults as $searchResult): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($searchResult['category']); ?></td>
                                                <td><strong><?php echo htmlspecialchars($searchResult['title'] ?? ''); ?></strong></td>
                                                <td><?php echo htmlspecialchars($searchResult['detail'] ?? ''); ?></td>
                                                <td><a href="tools.php?section=<?php echo urlencode($searchResult['target']); ?>">Browse section</a></td>
                                                <td><?php if ($searchResult['source_url']): ?><a href="<?php echo htmlspecialchars($searchResult['source_url']); ?>" target="_blank" rel="noopener noreferrer">Source</a><?php else: ?>Not linked<?php endif; ?></td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table></div>
                            <?php else: ?>
                                <div class="empty-state">No matching knowledge-base records were found. Try a shorter term, an alternate spelling, or an official identifier.</div>
                            <?php endif; ?>
                        <?php endif; ?>
                    </section>
                <?php elseif ($section === 'molecular'): ?>
                    <label class="search-box"><i class="fa-solid fa-magnifying-glass"></i><input type="search" data-table-search placeholder="Filter genes, proteins, and pathways" aria-label="Filter molecular associations"></label>
                    <section class="panel">
                        <h3>Genes</h3>
                        <div class="table-wrap"><table class="data-table" data-search-table><thead><tr><th>Deficiency</th><th>Gene</th><th>NCBI Gene ID</th><th>Name and biological context</th><th>Reference</th></tr></thead><tbody>
                            <?php foreach ($genes as $gene): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($gene['deficiency_name']); ?></td>
                                    <td><strong><?php echo htmlspecialchars($gene['gene_symbol']); ?></strong></td>
                                    <td><?php echo $gene['ncbi_gene_id'] !== null ? (int)$gene['ncbi_gene_id'] : 'Not recorded'; ?></td>
                                    <td><?php echo htmlspecialchars($gene['gene_name'] ?? ''); ?><br><small><?php echo htmlspecialchars($gene['association_description'] ?? 'Biological association details have not been added.'); ?></small></td>
                                    <td><?php if ($gene['source_url']): ?><a href="<?php echo htmlspecialchars($gene['source_url']); ?>" target="_blank" rel="noopener noreferrer">NCBI Gene</a><?php else: ?>—<?php endif; ?></td>
                                </tr>
                            <?php endforeach; ?>
                            <?php if (!$genes): ?><tr><td colspan="5"><div class="empty-state">No gene associations are currently available.</div></td></tr><?php endif; ?>
                        </tbody></table></div>
                    </section>
                    <section class="panel">
                        <h3>Proteins</h3>
                        <div class="table-wrap"><table class="data-table" data-search-table><thead><tr><th>Deficiency</th><th>Protein and function</th><th>UniProt accession</th><th>Association context</th><th>Reference</th></tr></thead><tbody>
                            <?php foreach ($proteins as $protein): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($protein['deficiency_name']); ?></td>
                                    <td><strong><?php echo htmlspecialchars($protein['protein_name'] ?? ''); ?></strong><br><small><?php echo htmlspecialchars($protein['protein_function'] ?? 'Function details have not been added.'); ?></small></td>
                                    <td><?php echo htmlspecialchars($protein['uniprot_accession'] ?? 'Not recorded'); ?></td>
                                    <td><?php echo htmlspecialchars($protein['association_description'] ?? 'Association details have not been added.'); ?></td>
                                    <td><?php if ($protein['source_url']): ?><a href="<?php echo htmlspecialchars($protein['source_url']); ?>" target="_blank" rel="noopener noreferrer">UniProt</a><?php else: ?>—<?php endif; ?></td>
                                </tr>
                            <?php endforeach; ?>
                            <?php if (!$proteins): ?><tr><td colspan="5"><div class="empty-state">No protein associations are currently available.</div></td></tr><?php endif; ?>
                        </tbody></table></div>
                    </section>
                    <section class="panel">
                        <h3>Pathways</h3>
                        <div class="table-wrap"><table class="data-table" data-search-table><thead><tr><th>Deficiency</th><th>Pathway</th><th>Identifier</th><th>Source and verification note</th></tr></thead><tbody>
                            <?php foreach ($pathways as $pathway): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($pathway['deficiency_name']); ?></td>
                                    <td><?php echo htmlspecialchars($pathway['pathway_name'] ?? ''); ?></td>
                                    <td><?php echo htmlspecialchars($pathway['pathway_id'] ?: 'Not verified'); ?></td>
                                    <td><?php echo htmlspecialchars($pathway['pathway_description'] ?? 'Pathway mapping has not been verified.'); ?>
                                        <?php if ($pathway['source_url']): ?><br><a href="<?php echo htmlspecialchars($pathway['source_url']); ?>" target="_blank" rel="noopener noreferrer">Reactome</a><?php endif; ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                            <?php if (!$pathways): ?><tr><td colspan="4"><div class="empty-state">No pathway associations are currently available.</div></td></tr><?php endif; ?>
                        </tbody></table></div>
                    </section>
                <?php elseif ($section === 'nutrition'): ?>
                    <div class="alert alert-info" role="note">
                        These foods are dietary sources of the listed nutrients, not a diagnosis or guaranteed treatment. Nutrient content varies, and a confirmed deficiency may need testing or clinician-directed treatment. Ask a healthcare professional for advice if you are pregnant, have kidney or thyroid disease, or take medicines affected by diet.
                    </div>
                    <label class="search-box"><i class="fa-solid fa-magnifying-glass"></i><input type="search" data-table-search placeholder="Filter foods and deficiencies" aria-label="Filter nutrition recommendations"></label>
                    <section class="panel">
                        <div class="table-wrap"><table class="data-table" data-search-table><thead><tr><th>Deficiency</th><th>Food</th><th>Nutrient</th><th>Benefits</th><th>Caution</th><th>Source</th></tr></thead><tbody>
                            <?php foreach ($foods as $food): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($food['deficiency_name']); ?></td>
                                    <td><strong><?php echo htmlspecialchars($food['food_name'] ?? ''); ?></strong></td>
                                    <td><?php echo htmlspecialchars($food['nutrient_name'] ?? ''); ?></td>
                                    <td><?php echo htmlspecialchars(trim((string)$food['benefits']) !== '' ? $food['benefits'] : 'No guidance provided.'); ?></td>
                                    <td><?php echo htmlspecialchars(trim((string)$food['avoid_food']) !== '' ? $food['avoid_food'] : 'No guidance provided.'); ?></td>
                                    <td><?php if ($food['source_url']): ?><a href="<?php echo htmlspecialchars($food['source_url']); ?>" target="_blank" rel="noopener noreferrer">Nutrient reference</a><?php else: ?>Not linked<?php endif; ?></td>
                                </tr>
                            <?php endforeach; ?>
                            <?php if (!$foods): ?><tr><td colspan="6"><div class="empty-state">No food recommendations are currently available.</div></td></tr><?php endif; ?>
                        </tbody></table></div>
                    </section>
                    <?php if ($foodNutrientData): ?>
                        <section class="panel">
                            <h3>USDA FoodData Central composition records</h3>
                            <p class="text-muted">These are source-checked nutrient measurements from the exact USDA records shown; they are not automatic matches to the recommendation foods above.</p>
                            <div class="table-wrap"><table class="data-table" data-search-table>
                                <thead><tr><th>Food record</th><th>Nutrient</th><th>Amount</th><th>Basis</th><th>Verification</th><th>Source</th></tr></thead>
                                <tbody>
                                    <?php foreach ($foodNutrientData as $foodNutrient): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($foodNutrient['food_name']); ?> (FDC #<?php echo (int)$foodNutrient['fdc_id']; ?>)</td>
                                            <td><?php echo htmlspecialchars($foodNutrient['nutrient_name']); ?></td>
                                            <td><?php echo htmlspecialchars($foodNutrient['nutrient_amount'] . ' ' . $foodNutrient['nutrient_unit']); ?></td>
                                            <td><?php echo htmlspecialchars($foodNutrient['serving_basis']); ?></td>
                                            <td><?php echo htmlspecialchars($foodNutrient['verification_status']); ?></td>
                                            <td><a href="<?php echo htmlspecialchars($foodNutrient['source_url']); ?>" target="_blank" rel="noopener noreferrer">USDA FDC record</a></td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table></div>
                        </section>
                    <?php endif; ?>
                <?php elseif ($section === 'resources'): ?>
                    <section class="panel"><div class="resource-grid">
                        <?php foreach ($resources as $resource): ?>
                            <article class="resource-card">
                                <h4><?php echo htmlspecialchars($resource[0]); ?></h4>
                                <p><?php echo htmlspecialchars($resource[1]); ?></p>
                                <a href="<?php echo htmlspecialchars($resource[2]); ?>" target="_blank" rel="noopener noreferrer">Visit resource <i class="fa-solid fa-arrow-up-right-from-square"></i></a>
                            </article>
                        <?php endforeach; ?>
                    </div></section>
                    <section class="panel">
                        <h3>Dataset sources and provenance</h3>
                        <p class="text-muted">Records identify where dataset content came from and how it was checked. Unknown versions or licenses are labelled; source links do not mean every associated claim has been independently verified.</p>
                        <?php if ($datasetSources): ?>
                            <div class="table-wrap"><table class="data-table" data-search-table>
                                <thead><tr><th>Dataset</th><th>Organization / record</th><th>Version and access date</th><th>License</th><th>Verification status</th></tr></thead>
                                <tbody>
                                    <?php foreach ($datasetSources as $source): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($source['dataset_name']); ?></td>
                                            <td><?php echo htmlspecialchars($source['organization']); ?><br><small><?php echo htmlspecialchars($source['record_identifier']); ?></small>
                                                <?php if ($source['source_url']): ?><br><a href="<?php echo htmlspecialchars($source['source_url']); ?>" target="_blank" rel="noopener noreferrer">Open source</a><?php endif; ?>
                                            </td>
                                            <td><?php echo htmlspecialchars($source['version_or_release']); ?><br><small><?php echo htmlspecialchars($source['access_date']); ?></small></td>
                                            <td><?php echo htmlspecialchars($source['license']); ?></td>
                                            <td><?php echo htmlspecialchars($source['verification_status']); ?></td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table></div>
                        <?php else: ?>
                            <div class="empty-state">No dataset provenance records are currently available.</div>
                        <?php endif; ?>
                    </section>
                <?php elseif ($section === 'reference'): ?>
                    <div class="alert alert-info" role="note">
                        Symptoms can have many causes. The association weights below are DefiMap's project-specific rules, not probabilities or clinically validated diagnostic scores.
                    </div>
                    <label class="search-box"><i class="fa-solid fa-magnifying-glass"></i><input type="search" data-table-search placeholder="Filter deficiencies and symptoms" aria-label="Filter deficiency and symptom references"></label>
                    <p class="search-status" data-search-status aria-live="polite"></p>
                    <section class="panel">
                        <h3>Deficiency reference</h3>
                        <div class="table-wrap"><table class="data-table" data-search-table data-page-size="8">
                            <thead><tr><th>Deficiency</th><th>Nutrient</th><th>Summary</th><th>Cause context</th><th>Source</th></tr></thead>
                            <tbody>
                                <?php foreach ($deficiencyRecords as $record): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($record['deficiency_name']); ?></td>
                                        <td><?php echo htmlspecialchars($record['related_nutrient'] ?? ''); ?></td>
                                        <td><?php echo htmlspecialchars($record['description']); ?></td>
                                        <td><?php echo htmlspecialchars($record['cause']); ?></td>
                                        <td><?php if ($record['source_url']): ?><a href="<?php echo htmlspecialchars($record['source_url']); ?>" target="_blank" rel="noopener noreferrer">Nutrient fact sheet</a><?php else: ?>Not linked<?php endif; ?></td>
                                    </tr>
                                <?php endforeach; ?>
                                <?php if (!$deficiencyRecords): ?><tr><td colspan="5"><div class="empty-state">No deficiency reference records are available.</div></td></tr><?php endif; ?>
                            </tbody>
                        </table></div>
                        <div class="table-pagination" data-table-pagination aria-label="Deficiency reference pages"></div>
                    </section>
                    <section class="panel">
                        <h3>Symptom associations</h3>
                        <div class="table-wrap"><table class="data-table" data-search-table data-page-size="8">
                            <thead><tr><th>Deficiency</th><th>Symptom</th><th>Symptom context</th><th>Project weight</th><th>Evidence note</th><th>Background</th></tr></thead>
                            <tbody>
                                <?php foreach ($symptomMappings as $mapping): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($mapping['deficiency_name']); ?></td>
                                        <td><?php echo htmlspecialchars($mapping['symptom_name']); ?></td>
                                        <td><?php echo htmlspecialchars($mapping['symptom_description'] ?? 'Symptom context has not been added.'); ?></td>
                                        <td><?php echo (int)$mapping['weight']; ?> / 5</td>
                                        <td><?php echo htmlspecialchars($mapping['evidence_note'] ?? 'This project mapping has not been independently verified.'); ?></td>
                                        <td><?php if ($mapping['source_url']): ?><a href="<?php echo htmlspecialchars($mapping['source_url']); ?>" target="_blank" rel="noopener noreferrer">Nutrient background</a><?php else: ?>Not linked<?php endif; ?></td>
                                    </tr>
                                <?php endforeach; ?>
                                <?php if (!$symptomMappings): ?><tr><td colspan="6"><div class="empty-state">No symptom mappings are currently available.</div></td></tr><?php endif; ?>
                            </tbody>
                        </table></div>
                        <div class="table-pagination" data-table-pagination aria-label="Symptom association pages"></div>
                    </section>
                <?php else: ?>
                    <section class="panel">
                        <h3>Account details</h3>
                        <?php if ($settingsMessage !== ''): ?>
                            <div class="alert <?php echo $settingsError ? 'alert-danger' : 'alert-success'; ?>" role="status"><?php echo htmlspecialchars($settingsMessage); ?></div>
                        <?php endif; ?>
                        <form method="post" action="tools.php?section=settings">
                            <input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars($_SESSION['settings_csrf']); ?>">
                            <div class="form-grid">
                                <div class="field-block"><label for="name">Full name</label><input id="name" name="name" type="text" maxlength="100" required value="<?php echo htmlspecialchars($user['name']); ?>"></div>
                                <div class="field-block"><label for="email">Email address</label><input id="email" name="email" type="email" maxlength="100" required value="<?php echo htmlspecialchars($user['email']); ?>"></div>
                                <div class="field-block"><label for="current_password">Current password</label><input id="current_password" name="current_password" type="password" autocomplete="current-password" required></div>
                                <div class="field-block"><label for="new_password">New password <span class="text-muted">(optional)</span></label><input id="new_password" name="new_password" type="password" minlength="8" autocomplete="new-password"></div>
                                <div class="field-block full-width"><label for="confirm_password">Confirm new password</label><input id="confirm_password" name="confirm_password" type="password" minlength="8" autocomplete="new-password"></div>
                            </div>
                            <p class="text-muted mt-3 mb-0">Enter your current password to save changes. A new password must be at least 8 characters.</p>
                            <div class="form-actions"><button class="save-button" type="submit">Save account settings</button></div>
                        </form>
                    </section>
                <?php endif; ?>
            </div>
        </main>
    </div>
    <script>
        const searchInputs = document.querySelectorAll('[data-table-search]');
        const searchableTables = document.querySelectorAll('[data-search-table]');

        function updateTables(query) {
            const terms = query.trim().toLocaleLowerCase().split(/\s+/).filter(Boolean);
            let totalMatches = 0;

            searchableTables.forEach((table) => {
                const rows = Array.from(table.querySelectorAll('tbody tr'));
                const matchingRows = rows.filter((row) => {
                    const text = row.textContent.toLocaleLowerCase();
                    return terms.every((term) => text.includes(term));
                });
                const pageSize = Number(table.dataset.pageSize) || matchingRows.length || 1;
                const pageCount = Math.max(1, Math.ceil(matchingRows.length / pageSize));
                const pagination = table.closest('.panel')?.querySelector('[data-table-pagination]');
                const currentPage = Math.min(Number(table.dataset.currentPage) || 1, pageCount);
                table.dataset.currentPage = String(currentPage);
                totalMatches += matchingRows.length;

                rows.forEach((row) => {
                    row.hidden = true;
                });
                matchingRows
                    .slice((currentPage - 1) * pageSize, currentPage * pageSize)
                    .forEach((row) => {
                        row.hidden = false;
                    });

                if (pagination) {
                    const firstVisible = matchingRows.length ? (currentPage - 1) * pageSize + 1 : 0;
                    const lastVisible = Math.min(currentPage * pageSize, matchingRows.length);
                    pagination.replaceChildren();

                    const summary = document.createElement('span');
                    summary.textContent = `Showing ${firstVisible}–${lastVisible} of ${matchingRows.length}`;
                    pagination.append(summary);

                    if (pageCount > 1) {
                        const controls = document.createElement('span');
                        const previous = document.createElement('button');
                        previous.type = 'button';
                        previous.textContent = 'Previous';
                        previous.disabled = currentPage === 1;
                        previous.addEventListener('click', () => {
                            table.dataset.currentPage = String(currentPage - 1);
                            updateTables(searchInputs[0]?.value || '');
                        });

                        const next = document.createElement('button');
                        next.type = 'button';
                        next.textContent = 'Next';
                        next.disabled = currentPage === pageCount;
                        next.style.marginLeft = '8px';
                        next.addEventListener('click', () => {
                            table.dataset.currentPage = String(currentPage + 1);
                            updateTables(searchInputs[0]?.value || '');
                        });
                        controls.append(previous, next);
                        pagination.append(controls);
                    }
                }
            });

            const searchStatus = document.querySelector('[data-search-status]');
            if (searchStatus) {
                searchStatus.textContent = query.trim()
                    ? `${totalMatches} matching record${totalMatches === 1 ? '' : 's'}`
                    : '';
            }
        }

        searchInputs.forEach((searchInput) => {
            searchInput.addEventListener('input', () => {
                searchableTables.forEach((table) => {
                    table.dataset.currentPage = '1';
                });
                updateTables(searchInput.value);
            });
        });

        if (searchableTables.length) {
            updateTables(searchInputs[0]?.value || '');
        }
    </script>
</body>
</html>
