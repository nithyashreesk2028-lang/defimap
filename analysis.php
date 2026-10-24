<?php
require __DIR__ . DIRECTORY_SEPARATOR . 'bootstrap.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php?return=analysis.php");
    exit();
}

$formMessage = "";
$selectedSymptoms = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && !defimap_csrf_valid((string)($_POST['csrf_token'] ?? ''))) {
    http_response_code(403);
    $formMessage = "<div class='notice alert-danger'>Your session token is invalid. Refresh the page and try again.</div>";
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $postedSymptoms = $_POST['symptoms'] ?? [];
    $selectedSymptoms = is_array($postedSymptoms)
        ? array_values(array_unique(array_filter(array_map('intval', $postedSymptoms), static fn(int $id): bool => $id > 0)))
        : [];
    $diet = trim((string)($_POST['diet'] ?? ''));
    $water = trim((string)($_POST['water_intake'] ?? ''));
    $exercise = trim((string)($_POST['exercise'] ?? ''));
    $sleep = trim((string)($_POST['sleep_hours'] ?? ''));
    $stress = trim((string)($_POST['stress_level'] ?? ''));
    $family = trim((string)($_POST['family_history'] ?? ''));
    $notes = trim((string)($_POST['notes'] ?? ''));

    if (empty($selectedSymptoms)) {
        $formMessage = "<div class='notice alert-danger'>Please select at least one symptom before running the assessment.</div>";
    } else {
        $scores = [];
        $query = $pdo->query("SELECT deficiency_id, deficiency_name FROM deficiency_master ORDER BY deficiency_name");
        while ($row = $query->fetch(PDO::FETCH_ASSOC)) {
            $scores[$row['deficiency_id']] = [
                'name' => $row['deficiency_name'],
                'score' => 0,
            ];
        }

        $placeholders = implode(',', array_fill(0, count($selectedSymptoms), '?'));
        $symptomStmt = $pdo->prepare("SELECT symptom_id, symptom_name FROM symptom_master WHERE symptom_id IN ($placeholders)");
        $symptomStmt->execute($selectedSymptoms);
        $validSymptoms = $symptomStmt->fetchAll(PDO::FETCH_KEY_PAIR);
        $selectedSymptoms = array_values(array_intersect($selectedSymptoms, array_map('intval', array_keys($validSymptoms))));

        if (!$selectedSymptoms) {
            $formMessage = "<div class='notice alert-danger'>The selected symptoms are not valid. Please select symptoms from the list and try again.</div>";
        } else {
            $placeholders = implode(',', array_fill(0, count($selectedSymptoms), '?'));
            $mappingStmt = $pdo->prepare("SELECT deficiency_id, weight FROM deficiency_symptoms WHERE symptom_id IN ($placeholders)");
            $mappingStmt->execute($selectedSymptoms);
            while ($row = $mappingStmt->fetch(PDO::FETCH_ASSOC)) {
                if (isset($scores[$row['deficiency_id']])) {
                    $scores[$row['deficiency_id']]['score'] += (int)$row['weight'];
                }
            }

            $bestDeficiency = "";
            $highestScore = 0;

            foreach ($scores as $item) {
                if ($item['score'] > $highestScore) {
                    $highestScore = $item['score'];
                    $bestDeficiency = $item['name'];
                }
            }

            $symptomNames = array_values($validSymptoms);

            $symptomText = implode(', ', $symptomNames);
            $insert = $pdo->prepare("INSERT INTO analyses (user_id, deficiency, score, symptoms, diet, family_history, notes, water_intake, exercise, sleep_hours, stress_level) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
            $data = [
                $_SESSION['user_id'],
                $bestDeficiency !== '' ? $bestDeficiency : null,
                $highestScore,
                $symptomText,
                $diet,
                $family,
                $notes,
                $water,
                $exercise,
                $sleep,
                $stress,
            ];

            $insert->execute($data);
            $analysisId = (int)$pdo->lastInsertId();
            header("Location: results.php?id=" . $analysisId);
            exit();
        }
    }
}

$allSymptoms = $pdo->query("SELECT symptom_id, symptom_name FROM symptom_master ORDER BY symptom_name")->fetchAll(PDO::FETCH_ASSOC);
$groups = [
    'General' => [],
    'Musculoskeletal' => [],
    'Neurological' => [],
    'Oral and skin' => [],
    'Other relevant symptoms' => [],
];

foreach ($allSymptoms as $symptom) {
    $name = strtolower($symptom['symptom_name']);
    if (in_array($name, ['fatigue', 'weakness', 'dizziness', 'loss of appetite', 'pale skin', 'shortness of breath'])) {
        $group = 'General';
    } elseif (in_array($name, ['bone pain', 'muscle cramps', 'joint pain', 'muscle weakness'])) {
        $group = 'Musculoskeletal';
    } elseif (in_array($name, ['numbness', 'headaches', 'headache', 'tingling', 'confusion'])) {
        $group = 'Neurological';
    } elseif (in_array($name, ['mouth ulcers', 'dry skin', 'brittle nails', 'hair loss', 'pale skin'])) {
        $group = 'Oral and skin';
    } else {
        $group = 'Other relevant symptoms';
    }

    $groups[$group][] = $symptom;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Start an Assessment | DefiMap</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        :root { --navy: #0B1F3A; --primary: #1456A0; --action: #1677E8; --pale: #F3F7FC; --white: #FFFFFF; --teal: #12A89D; --purple: #F2ECFF; --green: #EAF8F1; --orange: #FFF3E6; --text: #183153; --muted: #64748B; --border: #DCE7F3; --shadow: 0 18px 40px rgba(11, 31, 58, 0.08); }
        * { box-sizing: border-box; }
        body { margin: 0; font-family: "Segoe UI", Arial, sans-serif; background: var(--pale); color: var(--text); }
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
        .welcome-card p { margin: 0; color: rgba(255,255,255,0.82); max-width: 740px; line-height: 1.7; }
        .analysis-card { background: rgba(255,255,255,0.9); border: 1px solid var(--border); border-radius: 22px; box-shadow: var(--shadow); padding: 22px; }
        .workflow-tabs { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 22px; }
        .tab-button { appearance: none; background: #edf4ff; border: 1px solid var(--border); border-radius: 12px; padding: 12px 16px; color: var(--navy); font-weight: 700; display: inline-flex; align-items: center; gap: 8px; cursor: pointer; transition: all 0.2s ease; }
        .tab-button.active { background: rgba(20,86,160,0.1); border-color: rgba(20,86,160,0.25); color: var(--primary); }
        .tab-panel { display: none; opacity: 0; transform: translateY(6px); transition: opacity 0.2s ease, transform 0.2s ease; }
        .tab-panel.active { display: block; opacity: 1; transform: translateY(0); }
        .section-card { background: #fff; border: 1px solid var(--border); border-radius: 18px; padding: 20px; margin-bottom: 18px; }
        .section-card h3 { margin: 0 0 18px; color: var(--navy); font-size: 1.3rem; letter-spacing: -0.04em; }
        .symptom-header { display: flex; align-items: center; justify-content: space-between; gap: 14px; margin-bottom: 18px; flex-wrap: wrap; }
        .search-inline { flex: 1; min-width: 220px; display: flex; align-items: center; gap: 10px; border: 1px solid var(--border); border-radius: 12px; padding: 10px 12px; background: #f5f9ff; color: var(--muted); }
        .search-inline input { border: none; outline: none; width: 100%; background: transparent; color: var(--text); }
        .toggle-chip { display: inline-flex; align-items: center; gap: 8px; padding: 10px 12px; border-radius: 12px; border: 1px solid var(--border); background: #fefefe; color: var(--navy); font-weight: 600; }
        .symptom-group { margin-top: 18px; }
        .symptom-group h4 { margin: 0 0 10px; color: var(--navy); font-size: 0.95rem; letter-spacing: 0.06em; text-transform: uppercase; }
        .symptom-grid { display: grid; grid-template-columns: repeat(2, minmax(0,1fr)); gap: 12px; }
        .symptom-option { display: flex; align-items: center; gap: 10px; border: 1px solid var(--border); background: #fafcff; border-radius: 12px; padding: 12px 14px; color: var(--text); font-weight: 500; transition: all 0.2s ease; }
        .symptom-option.selected { border-color: rgba(20,86,160,0.35); background: rgba(20,86,160,0.05); color: var(--navy); }
        .symptom-option input { accent-color: var(--action); width: 18px; height: 18px; }
        .field-grid { display: grid; grid-template-columns: repeat(2, minmax(0,1fr)); gap: 18px; }
        .field-block { display: flex; flex-direction: column; gap: 8px; }
        .field-block label { font-weight: 600; color: var(--navy); }
        .field-block input, .field-block select, .field-block textarea { width: 100%; border: 1px solid var(--border); border-radius: 12px; background: #fbfdff; color: var(--text); padding: 12px 14px; min-height: 48px; transition: border-color 0.2s ease, box-shadow 0.2s ease; }
        .field-block input:focus, .field-block select:focus, .field-block textarea:focus { border-color: rgba(22,119,232,0.5); box-shadow: 0 0 0 0.2rem rgba(22,119,232,0.1); outline: none; }
        .field-block textarea { min-height: 120px; resize: vertical; }
        .inline-note { color: var(--muted); font-size: 0.85rem; }
        .form-actions { display: flex; justify-content: flex-end; gap: 12px; margin-top: 20px; }
        .btn { border: none; padding: 13px 20px; border-radius: 12px; font-weight: 700; display: inline-flex; align-items: center; justify-content: center; gap: 8px; transition: transform 0.2s ease, opacity 0.2s ease; }
        .btn:hover, .btn:focus-visible { transform: translateY(-1px); outline: none; }
        .btn-secondary { background: #eef4fb; color: var(--navy); }
        .btn-primary { background: linear-gradient(135deg, var(--action), var(--primary)); color: #fff; box-shadow: 0 12px 22px rgba(20,86,160,0.18); }
        .btn:disabled { opacity: 0.7; cursor: wait; transform: none; }
        .notice { border-radius: 12px; padding: 12px 14px; margin-bottom: 16px; font-weight: 600; }
        .notice.alert-danger { background: rgba(220, 53, 69, 0.06); color: #b42318; border: 1px solid rgba(220, 53, 69, 0.18); }
        @media (max-width: 1100px) { .app-shell { display: block; } .sidebar { width: 100%; height: auto; position: static; border-right: none; border-bottom: 1px solid rgba(255,255,255,0.08); } .field-grid, .symptom-grid { grid-template-columns: 1fr; } }
        @media (max-width: 768px) { .topbar-inner, .page-shell { padding-left: 16px; padding-right: 16px; } .topbar-inner { flex-wrap: wrap; } .search-box { min-width: 100%; } .workflow-tabs { overflow-x: auto; white-space: nowrap; } .form-actions { flex-direction: column-reverse; } .form-actions .btn { width: 100%; } }
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
                    <small>Nutrition Â· Genes Â· Health</small>
                </div>
            </div>
            <nav class="sidebar-nav" aria-label="Sidebar navigation">
            <div class="nav-group">
                <p class="nav-section-label">Workspace</p>
                <a class="nav-item" href="dashboard.php"><i class="fa-solid fa-house"></i> Home</a>
                <a class="nav-item active" href="analysis.php"><i class="fa-solid fa-microscope"></i> Start an Assessment</a>
                <a class="nav-item" href="reports.php"><i class="fa-solid fa-clock-rotate-left"></i> Reports &amp; History</a>
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
                <div class="sidebar-account-avatar"><?php echo htmlspecialchars(strtoupper(substr($_SESSION['user_name'], 0, 1))); ?></div>
                <div class="sidebar-account-copy"><strong><?php echo htmlspecialchars($_SESSION['user_name']); ?></strong><span>Research account</span></div>
            </div>
            <div class="sidebar-footer">Evidence-guided nutrition research</div>
        </aside>
        <main class="content">
            <header class="topbar">
                <div class="topbar-inner">
                    <div class="page-context"><i class="fa-solid fa-microscope"></i> <strong>Start an Assessment</strong> / Deficiency workflow</div>
                    <div class="topbar-tools">
                        <form class="search-box" method="get" action="tools.php" role="search" aria-label="Search the knowledge base">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="hidden" name="section" value="search">
                            <input type="search" name="q" placeholder="Search foods, nutrients, genes…" aria-label="Search foods, nutrients, genes, proteins and pathways">
                            <button type="submit" aria-label="Submit knowledge-base search"><i class="fa-solid fa-arrow-right"></i></button>
                        </form>
                        <button class="topbar-action" type="button" aria-label="Notifications"><i class="fa-solid fa-bell"></i></button>
                        <div class="profile-pill" aria-label="User profile">
                            <div class="avatar"><?php echo strtoupper(substr($_SESSION['user_name'], 0, 1)); ?></div>
                            <div class="profile-details">
                                <strong><?php echo htmlspecialchars($_SESSION['user_name']); ?></strong>
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
                        <h2>New Nutritional Deficiency Analysis</h2>
                        <p>Explore your symptoms, dietary intake, health indicators and related molecular evidence through a structured research workflow.</p>
                    </div>
                </section>
                <div class="analysis-card">
                    <?php echo $formMessage; ?>
                    <form id="analysisForm" method="POST">
                        <input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars(defimap_csrf_token(), ENT_QUOTES, 'UTF-8'); ?>">
                        <div class="workflow-tabs" role="tablist" aria-label="Assessment workflow tabs">
                            <button type="button" class="tab-button active" data-tab="symptoms" role="tab" aria-selected="true"><i class="fa-solid fa-heart-pulse"></i> Symptoms & Health</button>
                            <button type="button" class="tab-button" data-tab="dietary" role="tab" aria-selected="false"><i class="fa-solid fa-utensils"></i> Dietary Intake</button>
                            <button type="button" class="tab-button" data-tab="lab" role="tab" aria-selected="false"><i class="fa-solid fa-vials"></i> Laboratory Biomarkers</button>
                            <button type="button" class="tab-button" data-tab="anthro" role="tab" aria-selected="false"><i class="fa-solid fa-user-doctor"></i> Anthropometric & Family History</button>
                            <button type="button" class="tab-button" data-tab="additional" role="tab" aria-selected="false"><i class="fa-solid fa-file-lines"></i> Additional Information</button>
                        </div>

                        <div class="tab-panel active" id="symptoms" role="tabpanel">
                            <div class="section-card">
                                <div class="symptom-header">
                                    <div class="search-inline">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                        <input type="text" id="symptomSearch" placeholder="Search symptoms" aria-label="Search symptoms">
                                    </div>
                                    <label class="toggle-chip"><input type="checkbox" id="selectAllSymptoms"> Select all</label>
                                </div>
                                <?php foreach ($groups as $groupName => $items): ?>
                                    <div class="symptom-group">
                                        <h4><?php echo htmlspecialchars($groupName); ?></h4>
                                        <div class="symptom-grid">
                                            <?php foreach ($items as $symptom): ?>
                                                <?php $selected = in_array((int)$symptom['symptom_id'], $selectedSymptoms, true); ?>
                                                <label class="symptom-option <?php echo $selected ? 'selected' : ''; ?>">
                                                    <input type="checkbox" name="symptoms[]" value="<?php echo (int)$symptom['symptom_id']; ?>" <?php echo $selected ? 'checked' : ''; ?>>
                                                    <span><?php echo htmlspecialchars($symptom['symptom_name']); ?></span>
                                                </label>
                                            <?php endforeach; ?>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        </div>

                        <div class="tab-panel" id="dietary" role="tabpanel">
                            <div class="section-card">
                                <h3>Dietary Intake</h3>
                                <div class="field-grid">
                                    <div class="field-block"><label for="diet">Diet type</label><select id="diet" name="diet"><option value="">Select</option><option value="Balanced Diet" <?php echo (isset($_POST['diet']) && $_POST['diet'] === 'Balanced Diet') ? 'selected' : ''; ?>>Balanced Diet</option><option value="Vegetarian" <?php echo (isset($_POST['diet']) && $_POST['diet'] === 'Vegetarian') ? 'selected' : ''; ?>>Vegetarian</option><option value="Vegan" <?php echo (isset($_POST['diet']) && $_POST['diet'] === 'Vegan') ? 'selected' : ''; ?>>Vegan</option><option value="Non Vegetarian" <?php echo (isset($_POST['diet']) && $_POST['diet'] === 'Non Vegetarian') ? 'selected' : ''; ?>>Non Vegetarian</option><option value="High Protein" <?php echo (isset($_POST['diet']) && $_POST['diet'] === 'High Protein') ? 'selected' : ''; ?>>High Protein</option><option value="Low Dairy Intake" <?php echo (isset($_POST['diet']) && $_POST['diet'] === 'Low Dairy Intake') ? 'selected' : ''; ?>>Low Dairy Intake</option><option value="Junk Food Frequently" <?php echo (isset($_POST['diet']) && $_POST['diet'] === 'Junk Food Frequently') ? 'selected' : ''; ?>>Junk Food Frequently</option></select></div>
                                    <div class="field-block"><label for="water_intake">Water intake</label><select id="water_intake" name="water_intake"><option value="">Select</option><option value="Less than 1 Liter" <?php echo (isset($_POST['water_intake']) && $_POST['water_intake'] === 'Less than 1 Liter') ? 'selected' : ''; ?>>Less than 1 Liter</option><option value="1-2 Liters" <?php echo (isset($_POST['water_intake']) && $_POST['water_intake'] === '1-2 Liters') ? 'selected' : ''; ?>>1-2 Liters</option><option value="2-3 Liters" <?php echo (isset($_POST['water_intake']) && $_POST['water_intake'] === '2-3 Liters') ? 'selected' : ''; ?>>2-3 Liters</option><option value="More than 3 Liters" <?php echo (isset($_POST['water_intake']) && $_POST['water_intake'] === 'More than 3 Liters') ? 'selected' : ''; ?>>More than 3 Liters</option></select></div>
                                    <div class="field-block"><label for="exercise">Exercise pattern</label><select id="exercise" name="exercise"><option value="">Select</option><option value="Never" <?php echo (isset($_POST['exercise']) && $_POST['exercise'] === 'Never') ? 'selected' : ''; ?>>Never</option><option value="1-2 Days / Week" <?php echo (isset($_POST['exercise']) && $_POST['exercise'] === '1-2 Days / Week') ? 'selected' : ''; ?>>1-2 Days / Week</option><option value="3-5 Days / Week" <?php echo (isset($_POST['exercise']) && $_POST['exercise'] === '3-5 Days / Week') ? 'selected' : ''; ?>>3-5 Days / Week</option><option value="Daily" <?php echo (isset($_POST['exercise']) && $_POST['exercise'] === 'Daily') ? 'selected' : ''; ?>>Daily</option></select></div>
                                    <div class="field-block"><label for="sleep_hours">Sleep hours</label><select id="sleep_hours" name="sleep_hours"><option value="">Select</option><option value="Less than 5 Hours" <?php echo (isset($_POST['sleep_hours']) && $_POST['sleep_hours'] === 'Less than 5 Hours') ? 'selected' : ''; ?>>Less than 5 Hours</option><option value="5-7 Hours" <?php echo (isset($_POST['sleep_hours']) && $_POST['sleep_hours'] === '5-7 Hours') ? 'selected' : ''; ?>>5-7 Hours</option><option value="7-9 Hours" <?php echo (isset($_POST['sleep_hours']) && $_POST['sleep_hours'] === '7-9 Hours') ? 'selected' : ''; ?>>7-9 Hours</option><option value="More than 9 Hours" <?php echo (isset($_POST['sleep_hours']) && $_POST['sleep_hours'] === 'More than 9 Hours') ? 'selected' : ''; ?>>More than 9 Hours</option></select></div>
                                    <div class="field-block"><label for="stress_level">Stress level</label><select id="stress_level" name="stress_level"><option value="Low" <?php echo (isset($_POST['stress_level']) && $_POST['stress_level'] === 'Low') ? 'selected' : ''; ?>>Low</option><option value="Moderate" <?php echo (isset($_POST['stress_level']) && $_POST['stress_level'] === 'Moderate') ? 'selected' : ''; ?>>Moderate</option><option value="High" <?php echo (isset($_POST['stress_level']) && $_POST['stress_level'] === 'High') ? 'selected' : ''; ?>>High</option></select></div>
                                    <div class="field-block"><label for="family_history">Family history</label><select id="family_history" name="family_history"><option value="">None</option><option value="Anemia" <?php echo (isset($_POST['family_history']) && $_POST['family_history'] === 'Anemia') ? 'selected' : ''; ?>>Anemia</option><option value="Vitamin D Deficiency" <?php echo (isset($_POST['family_history']) && $_POST['family_history'] === 'Vitamin D Deficiency') ? 'selected' : ''; ?>>Vitamin D Deficiency</option><option value="Vitamin B12 Deficiency" <?php echo (isset($_POST['family_history']) && $_POST['family_history'] === 'Vitamin B12 Deficiency') ? 'selected' : ''; ?>>Vitamin B12 Deficiency</option><option value="Osteoporosis" <?php echo (isset($_POST['family_history']) && $_POST['family_history'] === 'Osteoporosis') ? 'selected' : ''; ?>>Osteoporosis</option></select></div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-panel" id="lab" role="tabpanel">
                            <div class="section-card">
                                <h3>Laboratory Biomarkers</h3>
                                <div class="field-grid">
                                    <div class="field-block"><label for="lab-name">Test name</label><input id="lab-name" type="text" name="lab_name" placeholder="e.g. Ferritin" value="<?php echo htmlspecialchars($_POST['lab_name'] ?? ''); ?>"></div>
                                    <div class="field-block"><label for="lab-value">Measured value</label><input id="lab-value" type="text" name="lab_value" placeholder="e.g. 32" value="<?php echo htmlspecialchars($_POST['lab_value'] ?? ''); ?>"></div>
                                    <div class="field-block"><label for="lab-unit">Unit</label><input id="lab-unit" type="text" name="lab_unit" placeholder="e.g. ng/mL" value="<?php echo htmlspecialchars($_POST['lab_unit'] ?? ''); ?>"></div>
                                    <div class="field-block"><label for="lab-date">Test date</label><input id="lab-date" type="date" name="lab_date" value="<?php echo htmlspecialchars($_POST['lab_date'] ?? ''); ?>"></div>
                                    <div class="field-block" style="grid-column: 1 / -1;"><label for="lab-range">Reference range</label><input id="lab-range" type="text" name="lab_range" placeholder="Optional laboratory reference range" value="<?php echo htmlspecialchars($_POST['lab_range'] ?? ''); ?>"></div>
                                </div>
                                <div class="inline-note">If available, record and review laboratory findings alongside related dietary and symptom information. Missing values are treated as unknown rather than normal.</div>
                            </div>
                        </div>

                        <div class="tab-panel" id="anthro" role="tabpanel">
                            <div class="section-card">
                                <h3>Anthropometric & Family History</h3>
                                <div class="field-grid">
                                    <div class="field-block"><label for="age-group">Age group</label><select id="age-group" name="age_group"><option value="">Select</option><option value="Child" <?php echo (isset($_POST['age_group']) && $_POST['age_group'] === 'Child') ? 'selected' : ''; ?>>Child</option><option value="Adolescent" <?php echo (isset($_POST['age_group']) && $_POST['age_group'] === 'Adolescent') ? 'selected' : ''; ?>>Adolescent</option><option value="Adult" <?php echo (isset($_POST['age_group']) && $_POST['age_group'] === 'Adult') ? 'selected' : ''; ?>>Adult</option><option value="Older adult" <?php echo (isset($_POST['age_group']) && $_POST['age_group'] === 'Older adult') ? 'selected' : ''; ?>>Older adult</option></select></div>
                                    <div class="field-block"><label for="dob">Date of birth</label><input id="dob" type="date" name="dob" value="<?php echo htmlspecialchars($_POST['dob'] ?? ''); ?>"></div>
                                    <div class="field-block"><label for="height">Height</label><input id="height" type="text" name="height" placeholder="e.g. 165 cm" value="<?php echo htmlspecialchars($_POST['height'] ?? ''); ?>"></div>
                                    <div class="field-block"><label for="weight">Weight</label><input id="weight" type="text" name="weight" placeholder="e.g. 62 kg" value="<?php echo htmlspecialchars($_POST['weight'] ?? ''); ?>"></div>
                                    <div class="field-block"><label for="measurement-date">Measurement date</label><input id="measurement-date" type="date" name="measurement_date" value="<?php echo htmlspecialchars($_POST['measurement_date'] ?? ''); ?>"></div>
                                    <div class="field-block"><label for="weight-change">Recent weight change</label><select id="weight-change" name="weight_change"><option value="">Select</option><option value="No change" <?php echo (isset($_POST['weight_change']) && $_POST['weight_change'] === 'No change') ? 'selected' : ''; ?>>No change</option><option value="Loss" <?php echo (isset($_POST['weight_change']) && $_POST['weight_change'] === 'Loss') ? 'selected' : ''; ?>>Loss</option><option value="Gain" <?php echo (isset($_POST['weight_change']) && $_POST['weight_change'] === 'Gain') ? 'selected' : ''; ?>>Gain</option></select></div>
                                    <div class="field-block"><label for="appetite">Appetite changes</label><select id="appetite" name="appetite_changes"><option value="">Select</option><option value="No change" <?php echo (isset($_POST['appetite_changes']) && $_POST['appetite_changes'] === 'No change') ? 'selected' : ''; ?>>No change</option><option value="Decreased" <?php echo (isset($_POST['appetite_changes']) && $_POST['appetite_changes'] === 'Decreased') ? 'selected' : ''; ?>>Decreased</option><option value="Increased" <?php echo (isset($_POST['appetite_changes']) && $_POST['appetite_changes'] === 'Increased') ? 'selected' : ''; ?>>Increased</option></select></div>
                                    <div class="field-block"><label for="dietary-restrictions">Dietary restrictions</label><input id="dietary-restrictions" type="text" name="dietary_restrictions" placeholder="Vegetarian, lactose-free, etc." value="<?php echo htmlspecialchars($_POST['dietary_restrictions'] ?? ''); ?>"></div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-panel" id="additional" role="tabpanel">
                            <div class="section-card">
                                <h3>Additional Information</h3>
                                <div class="field-grid">
                                    <div class="field-block" style="grid-column: 1 / -1;"><label for="notes">Relevant dietary context and notes</label><textarea id="notes" name="notes" placeholder="Add any relevant diet, lifestyle, medication, chronic illness or environmental context."><?php echo htmlspecialchars($_POST['notes'] ?? ''); ?></textarea></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="reset" class="btn btn-secondary"><i class="fa-solid fa-rotate-left"></i> Reset</button>
                            <button type="submit" name="analyze" class="btn btn-primary submit-btn"><i class="fa-solid fa-magnifying-glass-chart"></i> Analyze & Get Insights</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
    <script>
        const tabButtons = document.querySelectorAll('.tab-button');
        const panels = document.querySelectorAll('.tab-panel');
        const activateTab = (target) => {
            const selectedButton = Array.from(tabButtons).find((button) => button.dataset.tab === target);
            if (!selectedButton) return;
            tabButtons.forEach((button) => {
                const active = button === selectedButton;
                button.classList.toggle('active', active);
                button.setAttribute('aria-selected', active ? 'true' : 'false');
            });
            panels.forEach((panel) => panel.classList.toggle('active', panel.id === target));
        };
        tabButtons.forEach((button) => button.addEventListener('click', () => activateTab(button.dataset.tab)));
        if (window.location.hash) activateTab(window.location.hash.slice(1));
        window.addEventListener('hashchange', () => activateTab(window.location.hash.slice(1)));
        const symptomSearch = document.getElementById('symptomSearch');
        const symptomLabels = document.querySelectorAll('.symptom-option');
        if (symptomSearch) { symptomSearch.addEventListener('input', function () { const value = this.value.trim().toLowerCase(); symptomLabels.forEach((label) => { const text = label.textContent.toLowerCase(); label.style.display = text.includes(value) || value === '' ? '' : 'none'; }); }); }
        const selectAll = document.getElementById('selectAllSymptoms');
        if (selectAll) { selectAll.addEventListener('change', () => { const checked = selectAll.checked; document.querySelectorAll('input[name="symptoms[]"]').forEach((input) => { input.checked = checked; const option = input.closest('.symptom-option'); if (option) option.classList.toggle('selected', checked); }); }); }
        document.querySelectorAll('input[name="symptoms[]"]').forEach((input) => { input.addEventListener('change', () => { const option = input.closest('.symptom-option'); if (option) option.classList.toggle('selected', input.checked); }); });
        const form = document.getElementById('analysisForm');
        const submitBtn = document.querySelector('.submit-btn');
        if (form && submitBtn) { form.addEventListener('submit', () => { submitBtn.disabled = true; submitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Processingâ€¦'; }); }
    </script>
</body>
</html>
