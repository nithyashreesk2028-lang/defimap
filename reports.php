<?php
require __DIR__ . DIRECTORY_SEPARATOR . 'bootstrap.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php?return=reports.php");
    exit();
}

$userId = (int)$_SESSION['user_id'];
$userName = (string)($_SESSION['user_name'] ?? 'Research user');
$historyStmt = $pdo->prepare("SELECT id, deficiency, created_at FROM analyses WHERE user_id=? ORDER BY created_at DESC");
$historyStmt->execute([$userId]);
$history = $historyStmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports &amp; History | DefiMap</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        :root { --navy: #0B1F3A; --primary: #1456A0; --pale: #F3F7FC; --text: #183153; --muted: #64748B; --border: #DCE7F3; --shadow: 0 18px 40px rgba(11,31,58,.08); }
        * { box-sizing: border-box; }
        body { margin: 0; font-family: "Segoe UI", Arial, sans-serif; background: var(--pale); color: var(--text); }
        .app-shell { display: flex; min-height: 100vh; }
        .content { flex: 1; min-width: 0; }
        .topbar { position: sticky; top: 0; z-index: 2; background: rgba(255,255,255,.92); border-bottom: 1px solid var(--border); }
        .topbar-inner { max-width: 1320px; margin: 0 auto; padding: 18px 28px; display: flex; align-items: center; justify-content: space-between; gap: 18px; }
        .page-context { color: var(--muted); font-weight: 600; }
        .page-context strong { color: var(--navy); }
        .profile { color: var(--navy); font-weight: 600; }
        .logout-link { margin-left: 16px; color: var(--navy); font-weight: 600; text-decoration: none; }
        .page-shell { max-width: 1320px; margin: 0 auto; padding: 30px 28px 42px; }
        .welcome-card { margin-bottom: 22px; padding: 26px 30px; border-radius: 22px; background: linear-gradient(135deg,#0b3d91,#1a68d1); color: #fff; box-shadow: var(--shadow); }
        .welcome-card h2 { margin: 0 0 8px; }
        .welcome-card p { margin: 0; color: rgba(255,255,255,.84); }
        .panel { padding: 22px; border: 1px solid var(--border); border-radius: 18px; background: #fff; box-shadow: var(--shadow); }
        .panel h3 { margin: 0 0 12px; color: var(--navy); font-size: 1.3rem; }
        .history-table { width: 100%; border-collapse: collapse; }
        .history-table th, .history-table td { padding: 12px 10px; border-bottom: 1px solid var(--border); text-align: left; vertical-align: middle; }
        .history-table thead th { color: var(--muted); font-size: .78rem; letter-spacing: .05em; text-transform: uppercase; }
        .history-table tbody tr:last-child td { border-bottom: 0; }
        .status-pill { display: inline-flex; padding: 6px 10px; border-radius: 999px; background: rgba(18,168,157,.12); color: #0b7d74; font-size: .72rem; font-weight: 700; }
        .empty-state { padding: 16px 18px; border-radius: 12px; background: #f7fafd; border: 1px dashed var(--border); color: var(--muted); text-align: center; }
        .soft-link { color: var(--primary); font-weight: 700; text-decoration: none; }
        @media (max-width: 1100px) { .app-shell { display: block; } }
        @media (max-width: 700px) { .topbar-inner, .page-shell { padding-left: 16px; padding-right: 16px; } .topbar-inner { align-items: flex-start; flex-direction: column; } .history-table { display: block; overflow-x: auto; } }
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
                    <a class="nav-item active" href="reports.php" aria-current="page"><i class="fa-solid fa-clock-rotate-left"></i> Reports &amp; History</a>
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
        </aside>
        <main class="content">
            <header class="topbar">
                <div class="topbar-inner">
                    <div class="page-context"><i class="fa-solid fa-clock-rotate-left"></i> <strong>Reports &amp; History</strong> / Workspace</div>
                    <div><span class="profile"><?php echo htmlspecialchars($userName); ?></span><form class="logout-form" method="post" action="logout.php"><input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars(defimap_csrf_token(), ENT_QUOTES, 'UTF-8'); ?>"><button class="logout-link" type="submit"><i class="fa-solid fa-right-from-bracket"></i> Logout</button></form><?php defimap_theme_control(); ?></div>
                </div>
            </header>
            <div class="page-shell">
                <section class="welcome-card">
                    <h2>Reports &amp; History</h2>
                    <p>Review your saved assessments and reopen a report. Results are educational and do not establish a diagnosis.</p>
                </section>
                <section class="panel" id="history">
                    <h3>Saved reports and case history</h3>
                    <p>Each row is a saved assessment from your account. Select <strong>Open</strong> to review its report and references.</p>
                    <table class="history-table" aria-label="Saved reports and case history">
                        <thead><tr><th>ID</th><th>Assessment</th><th>Status</th><th>Created</th><th>Action</th></tr></thead>
                        <tbody>
                            <?php if ($history): ?>
                                <?php foreach ($history as $row): ?>
                                    <tr>
                                        <td>#<?php echo (int)$row['id']; ?></td>
                                        <td><?php echo htmlspecialchars($row['deficiency'] ?: 'Assessment'); ?></td>
                                        <td><span class="status-pill">Completed</span></td>
                                        <td><?php echo htmlspecialchars($row['created_at']); ?></td>
                                        <td><a class="soft-link" href="results.php?id=<?php echo (int)$row['id']; ?>">Open report</a></td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <tr><td colspan="5"><div class="empty-state">No reports yet. <a class="soft-link" href="analysis.php">Start an assessment</a> to create one.</div></td></tr>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </section>
            </div>
        </main>
    </div>
</body>
</html>
