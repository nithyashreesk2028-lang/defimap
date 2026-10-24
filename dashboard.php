<?php
require __DIR__ . DIRECTORY_SEPARATOR . 'bootstrap.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php?return=dashboard.php");
    exit();
}

$userName = $_SESSION['user_name'];

$stmt = $pdo->prepare("SELECT COUNT(*) FROM analyses WHERE user_id=?");
$stmt->execute([$_SESSION['user_id']]);
$totalAnalysis = (int)$stmt->fetchColumn();

$latestStmt = $pdo->prepare("SELECT id, created_at, deficiency FROM analyses WHERE user_id=? ORDER BY created_at DESC LIMIT 1");
$latestStmt->execute([$_SESSION['user_id']]);
$latestAnalysis = $latestStmt->fetch(PDO::FETCH_ASSOC);

$history = $pdo->prepare("SELECT id, deficiency, created_at FROM analyses WHERE user_id=? ORDER BY created_at DESC");
$history->execute([$_SESSION['user_id']]);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home | DefiMap</title>
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
        body { margin: 0; font-family: "Segoe UI", Arial, sans-serif; background: #eef5ff; color: var(--text); }
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
        .search-box input { border: none; background: transparent; width: 100%; outline: none; color: var(--text); }
        .search-box button { border: 0; background: transparent; color: var(--primary); cursor: pointer; }
        .topbar-action, .profile-pill, .logout-link { display: inline-flex; align-items: center; gap: 10px; border-radius: 12px; border: 1px solid var(--border); background: var(--white); color: var(--navy); padding: 10px 14px; font-weight: 600; }
        .topbar-action { width: 42px; height: 42px; justify-content: center; padding: 0; }
        .profile-pill { gap: 12px; padding-right: 18px; }
        .avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--primary), #60a5fa); color: #fff; display: grid; place-items: center; font-weight: 700; font-size: 0.86rem; }
        .profile-details { display: flex; flex-direction: column; line-height: 1.2; }
        .profile-details span { font-size: 0.72rem; color: var(--muted); }
        .logout-link { text-decoration: none; color: var(--navy); }
        .page-shell { max-width: 1320px; margin: 0 auto; padding: 30px 28px 42px; }
        .welcome-card { background: linear-gradient(135deg, #0b3d91 0%, #1a68d1 100%); color: #fff; border-radius: 22px; padding: 28px 30px; box-shadow: var(--shadow); display: flex; align-items: center; justify-content: space-between; gap: 20px; margin-bottom: 28px; }
        .welcome-card h2 { margin: 0 0 8px; font-size: clamp(2rem, 3vw, 2.8rem); letter-spacing: -0.06em; }
        .welcome-card p { margin: 0; color: rgba(255,255,255,0.8); font-size: 1.02rem; }
        .welcome-card .meta { display: inline-flex; align-items: center; gap: 8px; margin-top: 14px; font-size: 0.86rem; color: rgba(255,255,255,0.84); }
        .primary-btn { display: inline-flex; align-items: center; justify-content: center; gap: 8px; padding: 12px 18px; border-radius: 999px; font-weight: 700; background: #fff; color: var(--navy); text-decoration: none; box-shadow: 0 12px 24px rgba(2, 17, 33, 0.12); }
        .primary-btn:hover, .primary-btn:focus-visible { color: var(--navy); background: #eaf3ff; text-decoration: none; transform: translateY(-1px); }
        :root[data-theme="dark"] .welcome-card .primary-btn,
        :root[data-theme="dark"] .welcome-card .primary-btn:hover,
        :root[data-theme="dark"] .welcome-card .primary-btn:focus-visible {
            color: #0b1f3a !important;
            background: #f4f8ff;
            outline-color: #fff;
        }
        .page-title { margin: 8px 0 20px; color: var(--navy); font-size: clamp(1.8rem, 2vw, 2.2rem); letter-spacing: -0.05em; }
        .stats-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 18px; margin-bottom: 28px; }
        .stat-card, .panel, .action-card { background: #fff; border: 1px solid var(--border); border-radius: 18px; box-shadow: var(--shadow); }
        .stat-card { padding: 22px; }
        .stat-card .icon { width: 52px; height: 52px; border-radius: 16px; display: grid; place-items: center; font-size: 1.25rem; margin-bottom: 16px; color: var(--primary); background: rgba(20,86,160,0.08); }
        .stat-card h3 { margin: 0; font-size: 2rem; color: var(--navy); letter-spacing: -0.05em; }
        .stat-card p { margin: 10px 0 0; color: var(--muted); }
        .grid-3 { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 18px; margin-bottom: 28px; }
        .action-card { padding: 22px; display: flex; flex-direction: column; align-items: flex-start; height: 100%; }
        .action-card .icon { width: 52px; height: 52px; border-radius: 16px; display: grid; place-items: center; margin-bottom: 14px; background: rgba(20,86,160,0.08); color: var(--primary); font-size: 1.25rem; }
        .action-card h4 { margin: 0 0 10px; color: var(--navy); font-size: 1.25rem; }
        .action-card p { margin: 0 0 18px; color: var(--muted); line-height: 1.7; }
        .panel { padding: 22px; }
        .panel h3 { margin: 0 0 18px; color: var(--navy); font-size: 1.4rem; letter-spacing: -0.03em; }
        .history-table { width: 100%; border-collapse: collapse; }
        .history-table th, .history-table td { border-bottom: 1px solid var(--border); padding: 12px 10px; text-align: left; vertical-align: middle; }
        .history-table thead th { color: var(--navy); font-size: 0.84rem; letter-spacing: 0.06em; text-transform: uppercase; background: linear-gradient(180deg, #f5f9ff, #edf4ff); }
        .status-pill { display: inline-flex; padding: 6px 10px; border-radius: 999px; font-size: 0.72rem; font-weight: 700; background: rgba(18,168,157,0.12); color: #0b7d74; }
        .empty-state { padding: 16px 18px; border-radius: 12px; background: #f7fafd; border: 1px dashed var(--border); color: var(--muted); text-align: center; }
        .soft-link { color: var(--primary); font-weight: 700; text-decoration: none; }
        @media (max-width: 1100px) { .app-shell { display: block; } .sidebar { width: 100%; height: auto; position: static; border-right: none; border-bottom: 1px solid rgba(255,255,255,0.08); } .stats-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); } .grid-3 { grid-template-columns: 1fr 1fr; } }
        @media (max-width: 768px) { .topbar-inner, .page-shell { padding-left: 16px; padding-right: 16px; } .topbar-inner { flex-wrap: wrap; } .search-box { min-width: 100%; } .welcome-card { display: block; } .stats-grid, .grid-3 { grid-template-columns: 1fr; } .history-table { display: block; overflow-x: auto; } }
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
                <a class="nav-item active" href="dashboard.php"><i class="fa-solid fa-house"></i> Home</a>
                <a class="nav-item" href="analysis.php"><i class="fa-solid fa-microscope"></i> Start an Assessment</a>
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
                <div class="sidebar-account-avatar"><?php echo htmlspecialchars(strtoupper(substr($userName, 0, 1))); ?></div>
                <div class="sidebar-account-copy"><strong><?php echo htmlspecialchars($userName); ?></strong><span>Research account</span></div>
            </div>
            <div class="sidebar-footer">Evidence-guided nutrition research</div>
        </aside>
        <main class="content">
            <header class="topbar">
                <div class="topbar-inner">
                    <div class="page-context"><i class="fa-solid fa-house"></i> <strong>Home</strong> / Overview</div>
                    <div class="topbar-tools">
                        <form class="search-box" method="get" action="tools.php" role="search" aria-label="Search the knowledge base">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="hidden" name="section" value="search">
                            <input type="search" name="q" placeholder="Search foods, nutrients, genes…" aria-label="Search foods, nutrients, genes, proteins and pathways">
                            <button type="submit" aria-label="Submit knowledge-base search"><i class="fa-solid fa-arrow-right"></i></button>
                        </form>
                        <button class="topbar-action" type="button" aria-label="Notifications"><i class="fa-solid fa-bell"></i></button>
                        <div class="profile-pill" aria-label="User profile">
                            <div class="avatar"><?php echo strtoupper(substr(htmlspecialchars($userName), 0, 1)); ?></div>
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
                        <h2>Welcome to your DefiMap workspace, <?php echo htmlspecialchars($userName); ?>.</h2>
                        <p>Start an educational symptom review, reopen your saved reports, or browse the knowledge base for nutrient and molecular background. Your reports stay in this workspace when you visit the reference library.</p>
                        <?php if ($latestAnalysis): ?>
                            <div class="meta"><i class="fa-solid fa-clock"></i> Last analysis: <?php echo htmlspecialchars($latestAnalysis['created_at']); ?></div>
                        <?php endif; ?>
                    </div>
                    <a class="primary-btn" href="analysis.php"><i class="fa-solid fa-play"></i> Start new analysis</a>
                </section>
                <h2 class="page-title">Choose what you want to do</h2>
                <div class="stats-grid">
                    <article class="stat-card">
                        <div class="icon"><i class="fa-solid fa-chart-column"></i></div>
                        <h3><?php echo $totalAnalysis; ?></h3>
                        <p>Total analyses</p>
                    </article>
                    <article class="stat-card">
                        <div class="icon"><i class="fa-solid fa-heart-pulse"></i></div>
                        <h3><?php echo ($latestAnalysis ? htmlspecialchars($latestAnalysis['deficiency']) : '—'); ?></h3>
                        <p>Latest possible association · not a diagnosis</p>
                    </article>
                    <article class="stat-card">
                        <div class="icon"><i class="fa-solid fa-clipboard-check"></i></div>
                        <h3>Educational</h3>
                        <p>Symptom associations are exploratory, not clinical conclusions</p>
                    </article>
                    <article class="stat-card">
                        <div class="icon"><i class="fa-solid fa-dna"></i></div>
                        <h3>Reference</h3>
                        <p>Explore nutrients, genes, proteins, pathways and sources</p>
                    </article>
                </div>
                <div class="grid-3">
                    <article class="action-card">
                        <div class="icon"><i class="fa-solid fa-microscope"></i></div>
                        <h4>Start an assessment</h4>
                        <p>Record selected symptoms and optional dietary or health context. DefiMap compares symptoms with its project associations; it cannot confirm a deficiency.</p>
                        <a class="soft-link" href="analysis.php">Choose symptoms <i class="fa-solid fa-arrow-right"></i></a>
                    </article>
                    <article class="action-card">
                        <div class="icon"><i class="fa-solid fa-file-waveform"></i></div>
                        <h4>Reports &amp; saved cases</h4>
                        <p>Return to any saved assessment, review its selected symptoms and open its possible associations and references.</p>
                        <a class="soft-link" href="reports.php">Browse saved reports <i class="fa-solid fa-arrow-right"></i></a>
                    </article>
                    <article class="action-card">
                        <div class="icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
                        <h4>Knowledge base</h4>
                        <p>Use the reference library to explore food and nutrient information, deficiency and symptom notes, molecular associations and linked scientific sources.</p>
                        <a class="soft-link" href="tools.php?section=reference">Browse the knowledge base <i class="fa-solid fa-arrow-right"></i></a>
                    </article>
                </div>
                <section class="panel" id="history">
                    <h3 id="saved">Saved reports and case history</h3>
                    <p>Each row is a saved assessment from your account. Select <strong>Open</strong> to view its full report. Use the knowledge base for background information; your saved cases remain here.</p>
                    <table class="history-table" aria-label="Recent analyses">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Assessment</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if ($history->rowCount() > 0): ?>
                                <?php while ($row = $history->fetch(PDO::FETCH_ASSOC)): ?>
                                    <tr data-history-row>
                                        <td>#<?php echo (int)$row['id']; ?></td>
                                        <td><?php echo htmlspecialchars($row['deficiency'] ?: 'Assessment'); ?></td>
                                        <td><span class="status-pill">Completed</span></td>
                                        <td><?php echo htmlspecialchars($row['created_at']); ?></td>
                                        <td><a class="soft-link" href="results.php?id=<?php echo (int)$row['id']; ?>">Open</a></td>
                                    </tr>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <tr>
                                    <td colspan="5"><div class="empty-state">No analyses yet. Start a new assessment to populate your history.</div></td>
                                </tr>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </section>
            </div>
        </main>
    </div>
</body>
</html>
