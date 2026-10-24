<?php
require __DIR__ . DIRECTORY_SEPARATOR . 'bootstrap.php';

if (!isset($_SESSION['user_id'])) {
    $requestedId = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
    $loginReturn = $requestedId ? 'results.php?id=' . $requestedId : 'dashboard.php';
    header("Location: index.php?return=" . rawurlencode($loginReturn));
    exit();
}

if (!isset($_GET['id'])) {
    header("Location: dashboard.php");
    exit();
}

$id = (int)$_GET['id'];
$userName = $_SESSION['user_name'];

$stmt = $pdo->prepare("SELECT * FROM analyses WHERE id=? AND user_id=?");
$stmt->execute([$id, $_SESSION['user_id']]);

if ($stmt->rowCount() == 0) {
    die("Analysis not found.");
}

$result = $stmt->fetch(PDO::FETCH_ASSOC);

$deficiency = (string)($result['deficiency'] ?? '');
$score = (int)$result['score'];
$symptoms = $result['symptoms'];
$diet = $result['diet'];
$family = $result['family_history'];
$date = $result['created_at'];

$stmt = $pdo->prepare("SELECT d.deficiency_id, d.description, d.cause, dm.related_nutrient, dm.source_url
    FROM deficiency_master d
    LEFT JOIN deficiency_metadata dm ON dm.deficiency_id=d.deficiency_id
    WHERE d.deficiency_name=?");
$def = null;
if ($deficiency !== '') {
    $stmt->execute([$deficiency]);
    $def = $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
}

$deficiencyId = (int)($def['deficiency_id'] ?? 0);
$description = $def['description'] ?? 'No supported deficiency association was found for the selected symptoms in the current dataset.';
$cause = $def['cause'] ?? 'The selected symptoms may have many causes; this dataset does not provide a supported deficiency match for them.';
$relatedNutrient = $def['related_nutrient'] ?? '';
$deficiencySource = $def['source_url'] ?? '';

$selectedSymptomNames = array_values(array_unique(array_filter(array_map(
    'trim',
    preg_split('/\s*[,;]\s*/', (string)$symptoms)
))));
$rankedDeficiencies = [];
if ($selectedSymptomNames) {
    $placeholders = implode(',', array_fill(0, count($selectedSymptomNames), '?'));
    $rankedStmt = $pdo->prepare("SELECT d.deficiency_id, d.deficiency_name, dm.source_url,
            SUM(ds.weight) AS association_score,
            COUNT(DISTINCT s.symptom_id) AS matched_symptom_count
        FROM deficiency_symptoms ds
        JOIN deficiency_master d ON d.deficiency_id=ds.deficiency_id
        JOIN symptom_master s ON s.symptom_id=ds.symptom_id
        LEFT JOIN deficiency_metadata dm ON dm.deficiency_id=d.deficiency_id
        WHERE s.symptom_name IN ($placeholders)
        GROUP BY d.deficiency_id, d.deficiency_name, dm.source_url
        ORDER BY association_score DESC, matched_symptom_count DESC, d.deficiency_name");
    $rankedStmt->execute($selectedSymptomNames);
    $rankedDeficiencies = $rankedStmt->fetchAll(PDO::FETCH_ASSOC);
}

$scoreEvidence = [];
if ($selectedSymptomNames) {
    $placeholders = implode(',', array_fill(0, count($selectedSymptomNames), '?'));
    $evidenceStmt = $pdo->prepare("SELECT s.symptom_name, sm.description AS symptom_description,
            ds.weight, dsm.evidence_note, dsm.source_url
        FROM deficiency_symptoms ds
        JOIN symptom_master s ON s.symptom_id=ds.symptom_id
        LEFT JOIN symptom_metadata sm ON sm.symptom_id=s.symptom_id
        LEFT JOIN deficiency_symptom_metadata dsm
            ON dsm.deficiency_id=ds.deficiency_id AND dsm.symptom_id=ds.symptom_id
        WHERE ds.deficiency_id=? AND s.symptom_name IN ($placeholders)
        ORDER BY s.symptom_name");
    $evidenceStmt->execute(array_merge([$deficiencyId], $selectedSymptomNames));
    $scoreEvidence = $evidenceStmt->fetchAll(PDO::FETCH_ASSOC);
}

$geneStmt = $pdo->prepare("SELECT g.gene_symbol, g.ncbi_gene_id, g.gene_name, gm.association_description, gm.source_url
    FROM gene_associations g
    LEFT JOIN gene_association_metadata gm ON gm.association_id=g.id
    WHERE g.deficiency_id=?
    ORDER BY g.gene_symbol");
$geneStmt->execute([$deficiencyId]);
$genes = $geneStmt->fetchAll(PDO::FETCH_ASSOC);

$proteinStmt = $pdo->prepare("SELECT p.protein_name, p.uniprot_accession, pm.protein_function, pm.association_description, pm.source_url
    FROM protein_associations p
    LEFT JOIN protein_association_metadata pm ON pm.association_id=p.id
    WHERE p.deficiency_id=?
    ORDER BY p.protein_name");
$proteinStmt->execute([$deficiencyId]);
$proteins = $proteinStmt->fetchAll(PDO::FETCH_ASSOC);

$pathwayStmt = $pdo->prepare("SELECT p.pathway_name, pm.pathway_id, pm.pathway_description, pm.source_url
    FROM pathway_associations p
    LEFT JOIN pathway_association_metadata pm ON pm.association_id=p.id
    WHERE p.deficiency_id=?
    ORDER BY p.pathway_name");
$pathwayStmt->execute([$deficiencyId]);
$pathways = $pathwayStmt->fetchAll(PDO::FETCH_ASSOC);

$foodStmt = $pdo->prepare("SELECT f.food_name, f.benefits, f.avoid_food, fm.nutrient_name, fm.source_url
    FROM food_recommendations f
    LEFT JOIN food_recommendation_metadata fm ON fm.food_recommendation_id=f.id
    WHERE f.deficiency_id=?
    ORDER BY f.food_name");
$foodStmt->execute([$deficiencyId]);
$foods = $foodStmt->fetchAll(PDO::FETCH_ASSOC);

$nutrientAliases = [
    'Vitamin B1 (thiamin)' => 'Thiamin',
    'Vitamin B2 (riboflavin)' => 'Riboflavin',
    'Vitamin B3 (niacin)' => 'Niacin',
    'Vitamin B6' => 'Vitamin B-6',
    'Vitamin B12' => 'Vitamin B-12',
];
$foodNutrientSearchTerm = $nutrientAliases[$relatedNutrient] ?? $relatedNutrient;
$foodNutrientData = [];
if ($foodNutrientSearchTerm !== '') {
    $foodNutrientStmt = $pdo->prepare("SELECT food_name, fdc_id, nutrient_name, nutrient_amount,
            nutrient_unit, serving_basis, source_url, verification_status
        FROM food_nutrient_data
        WHERE LOWER(nutrient_name) LIKE LOWER(?)
        ORDER BY food_name, nutrient_name");
    $foodNutrientStmt->execute(['%' . $foodNutrientSearchTerm . '%']);
    $foodNutrientData = $foodNutrientStmt->fetchAll(PDO::FETCH_ASSOC);
}

$compoundStmt = $pdo->prepare("SELECT compound_name, pubchem_cid, molecular_formula,
        molecular_weight, source_url, verification_status
    FROM compound_data
    WHERE LOWER(related_nutrient) = LOWER(?)
    ORDER BY compound_name");
$compoundStmt->execute([$relatedNutrient]);
$compounds = $compoundStmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analysis Results | DefiMap</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        :root {
            --navy: #0B1F3A;
            --primary: #1456A0;
            --action: #1677E8;
            --pale: #F3F7FC;
            --white: #FFFFFF;
            --teal: #12A89D;
            --purple: #F2ECFF;
            --green: #EAF8F1;
            --orange: #FFF3E6;
            --text: #183153;
            --muted: #64748B;
            --border: #DCE7F3;
            --shadow: 0 18px 40px rgba(11, 31, 58, 0.08);
        }
        * { box-sizing: border-box; }
        body { margin: 0; font-family: "Segoe UI", Arial, sans-serif; background: var(--pale); color: var(--text); }
        a { text-decoration: none; }
        .app-shell { display: flex; min-height: 100vh; }
        .sidebar { width: 240px; background: linear-gradient(180deg, #0B1F3A 0%, #0D2342 100%); color: #fff; padding: 22px 18px 18px; position: sticky; top: 0; height: 100vh; display: flex; flex-direction: column; border-right: 1px solid rgba(255,255,255,0.08); }
        .brand-box { display: flex; align-items: center; gap: 12px; padding: 8px 10px 18px; border-bottom: 1px solid rgba(255,255,255,0.08); margin-bottom: 18px; }
        .brand-icon { width: 44px; height: 44px; border-radius: 14px; display: grid; place-items: center; background: rgba(255,255,255,0.08); color: #fff; font-size: 1.2rem; }
        .brand-box h1 { margin: 0; font-size: 1.8rem; letter-spacing: -0.05em; }
        .brand-box small { display: block; color: rgba(255,255,255,0.7); letter-spacing: 0.08em; text-transform: uppercase; font-size: 0.62rem; }
        .nav-group { display: grid; gap: 8px; }
        .nav-group + .nav-group { padding-top: 10px; margin-top: 10px; border-top: 1px solid rgba(255,255,255,0.08); }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px 12px; border-radius: 12px; color: rgba(255,255,255,0.82); font-weight: 600; text-decoration: none; transition: all 0.2s ease; }
        .nav-item:hover, .nav-item:focus-visible { background: rgba(255,255,255,0.06); color: #fff; text-decoration: none; outline: none; }
        .nav-item.active { background: rgba(22,119,232,0.18); color: #fff; border: 1px solid rgba(124, 178, 255, 0.2); }
        .sidebar-footer { margin-top: auto; padding: 16px 12px 10px; border-top: 1px solid rgba(255,255,255,0.08); text-align: center; color: rgba(255,255,255,0.8); font-size: 0.82rem; line-height: 1.6; }
        .sidebar-meta { text-align: center; color: rgba(255,255,255,0.58); font-size: 0.72rem; padding-bottom: 4px; }
        .content { flex: 1; min-width: 0; }
        .topbar { background: rgba(255,255,255,0.75); border-bottom: 1px solid var(--border); backdrop-filter: blur(12px); position: sticky; top: 0; z-index: 25; }
        .topbar-inner { max-width: 1320px; margin: 0 auto; padding: 18px 28px; display: flex; align-items: center; justify-content: space-between; gap: 18px; }
        .page-context { display: flex; align-items: center; gap: 10px; color: var(--muted); font-weight: 600; }
        .page-context strong { color: var(--navy); }
        .topbar-tools { display: flex; align-items: center; justify-content: flex-end; gap: 14px; flex-wrap: wrap; }
        .search-box { min-width: 260px; display: flex; align-items: center; gap: 10px; background: #f3f7fd; border: 1px solid var(--border); border-radius: 14px; padding: 10px 14px; color: var(--muted); }
        .search-box input { width: 100%; border: none; outline: none; background: transparent; color: var(--text); }
        .search-box button { border: 0; background: transparent; color: var(--primary); cursor: pointer; }
        .topbar-action, .profile-pill, .logout-link { display: inline-flex; align-items: center; gap: 10px; border-radius: 12px; border: 1px solid var(--border); background: var(--white); color: var(--navy); padding: 10px 14px; font-weight: 600; }
        .topbar-action { width: 42px; height: 42px; justify-content: center; padding: 0; }
        .profile-pill { gap: 12px; padding-right: 18px; }
        .avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--primary), #60a5fa); color: #fff; display: grid; place-items: center; font-weight: 700; font-size: 0.86rem; }
        .profile-details { display: flex; flex-direction: column; line-height: 1.2; }
        .profile-details span { font-size: 0.72rem; color: var(--muted); }
        .logout-link { text-decoration: none; color: var(--navy); }
        .page-shell { max-width: 1320px; margin: 0 auto; padding: 30px 28px 42px; }
        .welcome-card { background: linear-gradient(135deg, #0b3d91 0%, #1a68d1 100%); color: #fff; border-radius: 22px; padding: 28px 30px; box-shadow: var(--shadow); margin-bottom: 28px; }
        .welcome-card h2 { margin: 0 0 8px; font-size: clamp(2rem, 3vw, 2.8rem); letter-spacing: -0.06em; }
        .welcome-card p { margin: 0; color: rgba(255,255,255,0.82); line-height: 1.7; }
        .stats-grid { display: grid; grid-template-columns: repeat(4, minmax(0,1fr)); gap: 18px; margin-bottom: 28px; }
        .stat-card, .panel, .info-card { background: #fff; border: 1px solid var(--border); border-radius: 18px; box-shadow: var(--shadow); }
        .stat-card { padding: 22px; }
        .stat-card .icon { width: 52px; height: 52px; border-radius: 16px; display: grid; place-items: center; font-size: 1.25rem; margin-bottom: 16px; color: var(--primary); background: rgba(20,86,160,0.08); }
        .stat-card h3 { margin: 0; font-size: 2rem; color: var(--navy); letter-spacing: -0.05em; }
        .stat-card p { margin: 10px 0 0; color: var(--muted); }
        .panel { padding: 22px; margin-bottom: 20px; }
        .panel h3 { margin: 0 0 18px; color: var(--navy); font-size: 1.4rem; letter-spacing: -0.03em; }
        .info-card { padding: 22px; }
        .info-grid { display: grid; grid-template-columns: repeat(2, minmax(0,1fr)); gap: 18px; margin-bottom: 22px; }
        .detail-list { list-style: none; padding: 0; margin: 0; }
        .detail-list li { padding: 11px 0; border-bottom: 1px solid var(--border); }
        .detail-list li:last-child { border-bottom: none; }
        .detail-label { display: block; font-size: 0.75rem; letter-spacing: 0.08em; text-transform: uppercase; color: var(--muted); font-weight: 700; margin-bottom: 6px; }
        .chip { display: inline-flex; align-items: center; padding: 0.45rem 0.8rem; border-radius: 999px; background: rgba(20,86,160,0.08); color: var(--primary); font-weight: 700; }
        .results-grid { display: grid; grid-template-columns: repeat(3, minmax(0,1fr)); gap: 18px; margin-bottom: 22px; }
        .assoc-box { background: #fff; border: 1px solid var(--border); border-radius: 18px; box-shadow: var(--shadow); padding: 22px; }
        .assoc-box h4 { margin: 0 0 16px; color: var(--navy); font-size: 1.2rem; }
        .assoc-box p { margin: 0 0 10px; color: var(--text); }
        .food-list { display: grid; gap: 12px; }
        .food-item { background: #fff; border: 1px solid var(--border); border-radius: 16px; padding: 18px; }
        .food-item h5 { margin: 0 0 10px; color: #1d7d5f; font-size: 1.1rem; }
        .food-item p { margin: 0 0 6px; color: var(--text); }
        .food-item .avoid { color: #b42318; }
        .btn { border: none; padding: 13px 20px; border-radius: 12px; font-weight: 700; display: inline-flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-primary { background: linear-gradient(135deg, var(--action), var(--primary)); color: #fff; box-shadow: 0 12px 22px rgba(20,86,160,0.18); }
        .btn-secondary { background: #eef4fb; color: var(--navy); }
        .btn-success { background: linear-gradient(135deg, #1fbf8f, #129778); color: #fff; }
        .actions { display: flex; justify-content: flex-end; gap: 12px; margin-top: 18px; flex-wrap: wrap; }
        .note-box { background: rgba(18,168,157,0.08); border: 1px solid rgba(18,168,157,0.18); border-radius: 16px; padding: 18px; color: var(--navy); }
        @media (max-width: 1100px) { .app-shell { display: block; } .sidebar { width: 100%; height: auto; position: static; border-right: none; border-bottom: 1px solid rgba(255,255,255,0.08); } .stats-grid, .results-grid, .info-grid { grid-template-columns: 1fr; } }
        @media (max-width: 768px) { .topbar-inner, .page-shell { padding-left: 16px; padding-right: 16px; } .topbar-inner { flex-wrap: wrap; } .search-box { min-width: 100%; } .actions { justify-content: stretch; } .actions .btn { width: 100%; } }
    </style>
    <?php defimap_theme_head(); ?>
</head>
<body>
    <div class="app-shell">
        <aside class="sidebar" aria-label="Sidebar navigation">
            <div class="brand-box">
                <div class="brand-icon"><i class="fa-solid fa-dna"></i></div>
                <div>
                    <h1>DefiMap</h1>
                    <small>Nutrition · Genes · Health</small>
                </div>
            </div>
            <nav class="sidebar-nav" aria-label="Sidebar navigation">
            <div class="nav-group">
                <p class="nav-section-label">Workspace</p>
                <a class="nav-item" href="dashboard.php"><i class="fa-solid fa-house"></i> Home</a>
                <a class="nav-item" href="analysis.php"><i class="fa-solid fa-microscope"></i> Start an Assessment</a>
                <a class="nav-item active" href="reports.php"><i class="fa-solid fa-clock-rotate-left"></i> Reports &amp; History</a>
                <a class="nav-item" href="dashboard.php#saved"><i class="fa-solid fa-bookmark"></i> Saved Cases</a>
                <a class="nav-item" href="tools.php?section=settings"><i class="fa-solid fa-gear"></i> Account Settings</a>
            </div>
            <div class="nav-group">
                <p class="nav-section-label">Knowledge base</p>
                <a class="nav-item" href="tools.php?section=molecular"><i class="fa-solid fa-magnifying-glass"></i> Genes, Proteins &amp; Pathways</a>
                <a class="nav-item" href="tools.php?section=nutrition"><i class="fa-solid fa-utensils"></i> Foods &amp; Nutrients</a>
                <a class="nav-item" href="tools.php?section=reference"><i class="fa-solid fa-book-medical"></i> Deficiency &amp; Symptom Guide</a>
                <a class="nav-item" href="tools.php?section=resources"><i class="fa-solid fa-book-open"></i> Scientific Sources</a>
            </div>
            </nav>
            <div class="sidebar-account">
                <div class="sidebar-account-avatar"><?php echo htmlspecialchars(strtoupper(substr($userName, 0, 1))); ?></div>
                <div class="sidebar-account-copy"><strong><?php echo htmlspecialchars($userName); ?></strong><span>Research account</span></div>
            </div>
            <div class="sidebar-footer">Evidence-guided nutrition research</div>
        </aside>
        <main class="content">
            <header class="topbar">
                <div class="topbar-inner">
                    <div class="page-context"><i class="fa-solid fa-chart-column"></i> <strong>Report</strong> / Assessment summary</div>
                    <div class="topbar-tools">
                        <form class="search-box" method="get" action="tools.php" role="search" aria-label="Search the knowledge base">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="hidden" name="section" value="search">
                            <input type="search" name="q" placeholder="Search foods, nutrients, genes…" aria-label="Search foods, nutrients, genes, proteins and pathways">
                            <button type="submit" aria-label="Submit knowledge-base search"><i class="fa-solid fa-arrow-right"></i></button>
                        </form>
                        <button class="topbar-action" type="button" aria-label="Notifications"><i class="fa-solid fa-bell"></i></button>
                        <div class="profile-pill" aria-label="User profile">
                            <div class="avatar"><?php echo strtoupper(substr($userName, 0, 1)); ?></div>
                            <div class="profile-details">
                                <strong><?php echo htmlspecialchars($userName); ?></strong>
                                <span>Research user</span>
                            </div>
                        </div>
                        <form class="logout-form" method="post" action="logout.php">
                            <input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars(defimap_csrf_token(), ENT_QUOTES, 'UTF-8'); ?>">
                            <button class="logout-link" type="submit"><i class="fa-solid fa-right-from-bracket"></i> Logout</button>
                        </form>
                        <?php defimap_theme_control(); ?>
                    </div>
                </div>
            </header>
            <div class="page-shell">
                <section class="welcome-card">
                    <div>
                        <h2><?php echo htmlspecialchars($deficiency !== '' ? $deficiency : 'No supported association found'); ?></h2>
                        <p><?php echo htmlspecialchars($description); ?></p>
                    </div>
                </section>

                <div class="stats-grid">
                    <article class="stat-card">
                        <div class="icon"><i class="fa-solid fa-heart-pulse"></i></div>
                        <h3><?php echo htmlspecialchars($deficiency !== '' ? $deficiency : 'No match'); ?></h3>
                        <p>Top association; not a diagnosis</p>
                    </article>
                    <article class="stat-card">
                        <div class="icon"><i class="fa-solid fa-gauge-high"></i></div>
                        <h3><?php echo (int)$score; ?></h3>
                        <p>Assessment score</p>
                    </article>
                    <article class="stat-card">
                        <div class="icon"><i class="fa-solid fa-list-check"></i></div>
                        <h3><?php echo count(array_filter(preg_split('/\s*[,;]\s*/', trim($symptoms) ?: ''))); ?></h3>
                        <p>Selected symptoms</p>
                    </article>
                    <article class="stat-card">
                        <div class="icon"><i class="fa-solid fa-calendar-days"></i></div>
                        <h3><?php echo htmlspecialchars(date('M j', strtotime($date))); ?></h3>
                        <p>Analysis date</p>
                    </article>
                </div>

                <section class="panel">
                    <h3><i class="fa-solid fa-ranking-star"></i> Possible deficiency associations</h3>
                    <p>Ranked by the sum of DefiMap's project-specific symptom weights. These scores are not probabilities, diagnostic results, or clinical recommendations.</p>
                    <?php if ($rankedDeficiencies): ?>
                        <div class="table-wrap"><table class="data-table">
                            <thead><tr><th>Possible association</th><th>Project score</th><th>Selected symptoms matched</th><th>Reference</th></tr></thead>
                            <tbody>
                                <?php foreach ($rankedDeficiencies as $candidate): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($candidate['deficiency_name']); ?></td>
                                        <td><?php echo (int)$candidate['association_score']; ?></td>
                                        <td><?php echo (int)$candidate['matched_symptom_count']; ?></td>
                                        <td><?php if ($candidate['source_url']): ?><a href="<?php echo htmlspecialchars($candidate['source_url']); ?>" target="_blank" rel="noopener noreferrer">Nutrient background</a><?php else: ?>Not linked<?php endif; ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table></div>
                    <?php else: ?>
                        <p class="note-box">No selected symptom has a mapped deficiency association in the current dataset. This is not evidence that a deficiency is present or absent.</p>
                    <?php endif; ?>
                </section>

                <section class="panel">
                    <h3><i class="fa-solid fa-file-waveform"></i> Report overview</h3>
                    <div class="info-grid">
                        <div class="info-card">
                            <ul class="detail-list">
                                <li>
                                    <span class="detail-label">Clinical summary</span>
                                    <div><?php echo nl2br(htmlspecialchars($description)); ?></div>
                                </li>
                                <li>
                                    <span class="detail-label">Why it may occur</span>
                                    <div><?php echo nl2br(htmlspecialchars($cause)); ?></div>
                                </li>
                                <?php if ($relatedNutrient !== ''): ?>
                                <li>
                                    <span class="detail-label">Related nutrient</span>
                                    <div><?php echo htmlspecialchars($relatedNutrient); ?>
                                        <?php if ($deficiencySource): ?> · <a href="<?php echo htmlspecialchars($deficiencySource); ?>" target="_blank" rel="noopener noreferrer">Source</a><?php endif; ?>
                                    </div>
                                </li>
                                <?php endif; ?>
                            </ul>
                        </div>
                        <div class="info-card">
                            <ul class="detail-list">
                                <li>
                                    <span class="detail-label">Symptoms</span>
                                    <div><?php echo nl2br(htmlspecialchars($symptoms)); ?></div>
                                </li>
                                <li>
                                    <span class="detail-label">Dietary context</span>
                                    <div><?php echo nl2br(htmlspecialchars($diet ?: 'Not supplied')); ?></div>
                                </li>
                                <li>
                                    <span class="detail-label">Family history</span>
                                    <div><?php echo nl2br(htmlspecialchars($family ?: 'Not supplied')); ?></div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </section>

                <section class="panel">
                    <h3><i class="fa-solid fa-list-check"></i> Symptom score explanation</h3>
                    <p>This score is an educational rule-based association sum, not a clinical probability or diagnosis. This breakdown reconstructs the calculation using the symptoms saved in this report and the current database mappings, which may have changed since the report was created.</p>
                    <?php if ($scoreEvidence): ?>
                        <div class="table-wrap"><table class="data-table">
                            <thead><tr><th>Selected symptom</th><th>Project weight</th><th>Context</th><th>Evidence note</th><th>Source</th></tr></thead>
                            <tbody>
                                <?php foreach ($scoreEvidence as $evidence): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($evidence['symptom_name']); ?></td>
                                        <td><?php echo (int)$evidence['weight']; ?></td>
                                        <td><?php echo htmlspecialchars($evidence['symptom_description'] ?? 'Symptom context has not been added.'); ?></td>
                                        <td><?php echo htmlspecialchars($evidence['evidence_note'] ?? 'Project association; not independently verified.'); ?></td>
                                        <td><?php if ($evidence['source_url']): ?><a href="<?php echo htmlspecialchars($evidence['source_url']); ?>" target="_blank" rel="noopener noreferrer">Reference</a><?php else: ?>Not linked<?php endif; ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table></div>
                    <?php else: ?>
                        <p class="note-box">No matching symptom-to-deficiency mapping is available to reconstruct this report's score.</p>
                    <?php endif; ?>
                    <p class="mb-0"><strong>Important:</strong> Symptoms can have many causes. Suspected deficiencies require assessment by a qualified healthcare professional.</p>
                </section>

                <section class="panel">
                    <h3><i class="fa-solid fa-dna"></i> Molecular evidence</h3>
                    <div class="results-grid">
                        <div class="assoc-box">
                            <h4><i class="fa-solid fa-dna"></i> Related genes</h4>
                            <?php if ($genes): ?>
                                <?php foreach ($genes as $gene): ?>
                                    <p>
                                        <span class="chip"><?php echo htmlspecialchars($gene['gene_symbol']); ?></span><br>
                                        <?php echo htmlspecialchars($gene['gene_name']); ?>
                                        <?php if ($gene['ncbi_gene_id']): ?><br><small>NCBI Gene ID: <?php echo (int)$gene['ncbi_gene_id']; ?></small><?php endif; ?><br>
                                        <small><?php echo htmlspecialchars($gene['association_description'] ?? 'Biological association details have not been added.'); ?></small>
                                        <?php if ($gene['source_url']): ?><br><a href="<?php echo htmlspecialchars($gene['source_url']); ?>" target="_blank" rel="noopener noreferrer">NCBI Gene source</a><?php endif; ?>
                                    </p>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <p>No gene associations are currently linked to this deficiency.</p>
                            <?php endif; ?>
                        </div>
                        <div class="assoc-box">
                            <h4><i class="fa-solid fa-circle-nodes"></i> Proteins</h4>
                            <?php if ($proteins): ?>
                                <?php foreach ($proteins as $protein): ?>
                                    <p>
                                        <strong><?php echo htmlspecialchars($protein['protein_name']); ?></strong><br>
                                        <?php if ($protein['uniprot_accession']): ?><small>UniProt accession: <?php echo htmlspecialchars($protein['uniprot_accession']); ?></small><br><?php endif; ?>
                                        <small><?php echo htmlspecialchars($protein['protein_function'] ?? 'Function details have not been added.'); ?></small><br>
                                        <small><?php echo htmlspecialchars($protein['association_description'] ?? 'Association details have not been added.'); ?></small>
                                        <?php if ($protein['source_url']): ?><br><a href="<?php echo htmlspecialchars($protein['source_url']); ?>" target="_blank" rel="noopener noreferrer">UniProt source</a><?php endif; ?>
                                    </p>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <p>No protein associations are currently linked to this deficiency.</p>
                            <?php endif; ?>
                        </div>
                        <div class="assoc-box">
                            <h4><i class="fa-solid fa-diagram-project"></i> Pathways</h4>
                            <?php if ($pathways): ?>
                                <?php foreach ($pathways as $pathway): ?>
                                    <p>
                                        <strong><?php echo htmlspecialchars($pathway['pathway_name']); ?></strong>
                                        <small>(<?php echo htmlspecialchars($pathway['pathway_id'] ?: 'Identifier not verified'); ?>)</small><br>
                                        <small><?php echo htmlspecialchars($pathway['pathway_description'] ?? 'Pathway mapping has not been verified.'); ?></small>
                                        <?php if ($pathway['source_url']): ?><br><a href="<?php echo htmlspecialchars($pathway['source_url']); ?>" target="_blank" rel="noopener noreferrer">Reactome reference</a><?php endif; ?>
                                    </p>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <p>No pathway associations are currently linked to this deficiency.</p>
                            <?php endif; ?>
                        </div>
                    </div>
                </section>

                <section class="panel">
                    <h3><i class="fa-solid fa-utensils"></i> Food guidance</h3>
                    <div class="food-list">
                        <?php if ($foods): ?>
                            <?php foreach ($foods as $food): ?>
                                <?php
                                $benefits = trim((string)$food['benefits']);
                                $avoidFood = trim((string)$food['avoid_food']);
                                ?>
                                <div class="food-item">
                                    <h5><?php echo htmlspecialchars($food['food_name']); ?></h5>
                                    <?php if ($food['nutrient_name']): ?><p><strong>Nutrient:</strong> <?php echo htmlspecialchars($food['nutrient_name']); ?></p><?php endif; ?>
                                    <p><strong>Benefits:</strong> <?php echo htmlspecialchars($benefits !== '' ? $benefits : 'No guidance provided.'); ?></p>
                                    <p class="avoid"><strong>Avoid:</strong> <?php echo htmlspecialchars($avoidFood !== '' ? $avoidFood : 'No guidance provided.'); ?></p>
                                    <?php if ($food['source_url']): ?><p><a href="<?php echo htmlspecialchars($food['source_url']); ?>" target="_blank" rel="noopener noreferrer">Nutrient background source</a></p><?php endif; ?>
                                </div>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <div class="note-box">No food recommendations are currently linked for this deficiency.</div>
                        <?php endif; ?>
                    </div>
                </section>

                <section class="panel">
                    <h3><i class="fa-solid fa-chart-column"></i> USDA food composition</h3>
                    <?php if ($foodNutrientData): ?>
                        <div class="table-wrap"><table class="data-table">
                            <thead><tr><th>Food</th><th>Measured nutrient</th><th>Amount</th><th>Basis</th><th>Source</th></tr></thead>
                            <tbody>
                                <?php foreach ($foodNutrientData as $foodNutrient): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($foodNutrient['food_name']); ?></td>
                                        <td><?php echo htmlspecialchars($foodNutrient['nutrient_name']); ?></td>
                                        <td><?php echo htmlspecialchars($foodNutrient['nutrient_amount'] . ' ' . $foodNutrient['nutrient_unit']); ?></td>
                                        <td><?php echo htmlspecialchars($foodNutrient['serving_basis']); ?></td>
                                        <td>
                                            <span><?php echo htmlspecialchars($foodNutrient['verification_status']); ?></span><br>
                                            <a href="<?php echo htmlspecialchars($foodNutrient['source_url']); ?>" target="_blank" rel="noopener noreferrer">FDC #<?php echo (int)$foodNutrient['fdc_id']; ?></a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table></div>
                    <?php else: ?>
                        <div class="note-box">No source-checked USDA FoodData Central composition records are loaded for this nutrient yet.</div>
                    <?php endif; ?>
                    <p class="mb-0"><small>Values are reported for the listed FDC food record and basis; they are not serving recommendations or a treatment plan.</small></p>
                </section>

                <?php if ($compounds): ?>
                    <section class="panel">
                        <h3><i class="fa-solid fa-flask"></i> Nutrient compounds</h3>
                        <div class="results-grid">
                            <?php foreach ($compounds as $compound): ?>
                                <div class="assoc-box">
                                    <h4><?php echo htmlspecialchars($compound['compound_name']); ?></h4>
                                    <p><strong>PubChem CID:</strong> <?php echo (int)$compound['pubchem_cid']; ?></p>
                                    <p><strong>Formula:</strong> <?php echo htmlspecialchars($compound['molecular_formula']); ?></p>
                                    <p><strong>Molecular weight:</strong> <?php echo htmlspecialchars($compound['molecular_weight']); ?> g/mol</p>
                                    <p><strong>Verification:</strong> <?php echo htmlspecialchars($compound['verification_status']); ?></p>
                                    <a href="<?php echo htmlspecialchars($compound['source_url']); ?>" target="_blank" rel="noopener noreferrer">PubChem source</a>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </section>
                <?php endif; ?>

                <section class="panel">
                    <h3><i class="fa-solid fa-circle-info"></i> Educational note</h3>
                    <div class="note-box">
                        This report is generated for educational and research-oriented interpretation. It does not diagnose disease or replace professional medical assessment. Clinical confirmation, laboratory testing and qualified review remain necessary before making treatment decisions.
                    </div>
                    <div class="actions">
                        <button class="btn btn-success" type="button" onclick="window.print();"><i class="fa-solid fa-print"></i> Print report</button>
                        <a href="analysis.php" class="btn btn-primary"><i class="fa-solid fa-microscope"></i> New analysis</a>
                        <a href="dashboard.php" class="btn btn-secondary"><i class="fa-solid fa-house"></i> Dashboard</a>
                    </div>
                </section>
            </div>
        </main>
    </div>
</body>
</html>
