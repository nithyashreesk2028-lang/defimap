<?php
require_once __DIR__ . DIRECTORY_SEPARATOR . 'env.php';

$appEnvironment = defimap_environment();
$host = getenv('DEFIMAP_DB_HOST') ?: 'localhost';
$dbname = getenv('DEFIMAP_DB_NAME') ?: 'defimap';
$username = getenv('DEFIMAP_DB_USER');
$password = getenv('DEFIMAP_DB_PASSWORD');

if ($appEnvironment === 'production') {
    global $defimapEnvironmentFileKeys;
    $databaseSettingsFromProcess = !in_array('DEFIMAP_DB_HOST', $defimapEnvironmentFileKeys, true)
        && !in_array('DEFIMAP_DB_NAME', $defimapEnvironmentFileKeys, true)
        && !in_array('DEFIMAP_DB_USER', $defimapEnvironmentFileKeys, true)
        && !in_array('DEFIMAP_DB_PASSWORD', $defimapEnvironmentFileKeys, true);
    if ($username === false || $username === '' || strtolower($username) === 'root'
        || $password === false || $password === ''
        || !$databaseSettingsFromProcess
        || getenv('DEFIMAP_DB_HOST') === false
        || getenv('DEFIMAP_DB_NAME') === false) {
        error_log('DefiMap production database configuration is incomplete or unsafe.');
        http_response_code(503);
        exit('The application is not configured. Please try again later.');
    }
} else {
    $username = $username === false ? 'root' : $username;
    $password = $password === false ? '' : $password;
}

try {
    $pdo = new PDO(
        "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
        $username,
        $password,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
} catch (PDOException $error) {
    error_log('DefiMap database connection failed: ' . $error->getMessage());
    http_response_code(503);
    exit('The application is temporarily unavailable. Please try again later.');
}

function defimap_theme_head(): void
{
    ?>
    <style>
        .logout-form { display: inline-flex; margin: 0; }
        .logout-link { font: inherit; cursor: pointer; }

        :root[data-theme="dark"] {
            color-scheme: dark;
            --navy: #e6eef8;
            --navy-strong: #edf4fc;
            --primary: #7dbaff;
            --action: #2388f4;
            --pale: #0b1422;
            --white: #142235;
            --teal: #51d4c7;
            --purple: #28243a;
            --green: #18352e;
            --orange: #382d1e;
            --text: #e3edf7;
            --muted: #a1b2c4;
            --border: #2a3d52;
            --shadow: 0 18px 40px rgba(0, 0, 0, .24);
        }

        :root[data-theme="dark"] body {
            color: var(--text) !important;
            background: #0b1422 !important;
            color-scheme: dark;
        }

        :root[data-theme="dark"] .section,
        :root[data-theme="dark"] .page-shell,
        :root[data-theme="dark"] .content {
            color: var(--text);
        }

        :root[data-theme="dark"] .feature-card,
        :root[data-theme="dark"] .form-panel,
        :root[data-theme="dark"] .info-panel,
        :root[data-theme="dark"] .mini-panel,
        :root[data-theme="dark"] .metric-box,
        :root[data-theme="dark"] .stat-card,
        :root[data-theme="dark"] .panel,
        :root[data-theme="dark"] .action-card,
        :root[data-theme="dark"] .analysis-card,
        :root[data-theme="dark"] .section-card,
        :root[data-theme="dark"] .info-card,
        :root[data-theme="dark"] .assoc-box,
        :root[data-theme="dark"] .food-item,
        :root[data-theme="dark"] .resource-card,
        :root[data-theme="dark"] .form-card,
        :root[data-theme="dark"] .content-card {
            color: var(--text) !important;
            background: #142235 !important;
            border-color: var(--border) !important;
            box-shadow: var(--shadow);
        }

        :root[data-theme="dark"] .topbar {
            background: rgba(12, 25, 40, .96) !important;
            border-color: var(--border) !important;
        }

        :root[data-theme="dark"] .topbar,
        :root[data-theme="dark"] .topbar a,
        :root[data-theme="dark"] .topbar .page-context,
        :root[data-theme="dark"] .topbar .profile,
        :root[data-theme="dark"] .topbar .logout-link {
            color: var(--text);
        }

        :root[data-theme="dark"] .section-header h2,
        :root[data-theme="dark"] .feature-card h3,
        :root[data-theme="dark"] .form-panel h3,
        :root[data-theme="dark"] .info-panel h3,
        :root[data-theme="dark"] .mini-panel h3,
        :root[data-theme="dark"] .metric-box strong,
        :root[data-theme="dark"] .page-title,
        :root[data-theme="dark"] .stat-card h3,
        :root[data-theme="dark"] .action-card h4,
        :root[data-theme="dark"] .panel h3,
        :root[data-theme="dark"] .section-card h3,
        :root[data-theme="dark"] .symptom-group h4,
        :root[data-theme="dark"] .assoc-box h4 {
            color: var(--navy) !important;
        }

        :root[data-theme="dark"] .section-header p,
        :root[data-theme="dark"] .feature-card p,
        :root[data-theme="dark"] .action-card p,
        :root[data-theme="dark"] .stat-card p,
        :root[data-theme="dark"] .assoc-box p,
        :root[data-theme="dark"] .food-item p,
        :root[data-theme="dark"] .inline-note,
        :root[data-theme="dark"] .detail-label {
            color: var(--muted);
        }

        :root[data-theme="dark"] .auth-form .form-control,
        :root[data-theme="dark"] .field-block input,
        :root[data-theme="dark"] .field-block select,
        :root[data-theme="dark"] .field-block textarea,
        :root[data-theme="dark"] .form-control,
        :root[data-theme="dark"] .form-select,
        :root[data-theme="dark"] input:not([type="checkbox"]):not([type="radio"]):not([type="submit"]),
        :root[data-theme="dark"] select,
        :root[data-theme="dark"] textarea,
        :root[data-theme="dark"] .search-box,
        :root[data-theme="dark"] .search-inline,
        :root[data-theme="dark"] .search-inline input {
            color: var(--text) !important;
            background-color: #0d1b2b !important;
            border-color: var(--border) !important;
        }

        :root[data-theme="dark"] input::placeholder,
        :root[data-theme="dark"] textarea::placeholder {
            color: #8ea1b5 !important;
        }

        :root[data-theme="dark"] .tab-button,
        :root[data-theme="dark"] .toggle-chip,
        :root[data-theme="dark"] .section-nav a,
        :root[data-theme="dark"] .btn-secondary {
            color: var(--text) !important;
            background: #1a2d43 !important;
            border-color: var(--border) !important;
        }

        :root[data-theme="dark"] .symptom-option,
        :root[data-theme="dark"] .empty-state {
            color: var(--text) !important;
            background: #102033 !important;
            border-color: var(--border) !important;
        }

        :root[data-theme="dark"] .history-table th,
        :root[data-theme="dark"] .history-table td,
        :root[data-theme="dark"] .data-table th,
        :root[data-theme="dark"] .data-table td {
            color: var(--text);
            border-color: var(--border) !important;
        }

        :root[data-theme="dark"] .history-table thead th {
            background: #1a2c41 !important;
        }

        :root[data-theme="dark"] .notice.alert-success { color: #a6efdb; background: #12372f; }
        :root[data-theme="dark"] .notice.alert-danger { color: #ffc1c5; background: #3a2027; }
        :root[data-theme="dark"] .notice.alert-warning { color: #f6d78d; background: #3b311b; }
        :root[data-theme="dark"] .food-item h5 { color: #85dfb8 !important; }
        :root[data-theme="dark"] .food-item .avoid { color: #ff9c9c !important; }
        :root[data-theme="dark"] .disclaimer { color: var(--muted); background: #142235; border-color: var(--border); }
        :root[data-theme="dark"] .disclaimer strong { color: var(--text); }
        :root[data-theme="dark"] .welcome-card,
        :root[data-theme="dark"] .hero,
        :root[data-theme="dark"] footer { color: #fff !important; }

        .app-shell > .sidebar {
            width: 264px;
            flex: 0 0 264px;
            padding: 24px 16px 18px;
            background: linear-gradient(180deg, #0b192b 0%, #0d2139 58%, #102945 100%);
            border-right: 1px solid rgba(255,255,255,.08);
            box-shadow: 8px 0 28px rgba(11,31,58,.08);
        }
        .sidebar .brand-box {
            gap: 12px;
            padding: 4px 8px 22px;
            margin-bottom: 22px;
            border-bottom-color: rgba(255,255,255,.1);
        }
        .sidebar .brand-icon {
            width: 46px;
            height: 46px;
            flex: 0 0 46px;
            border-radius: 15px;
            background: linear-gradient(145deg, #1688f8, #12a89d);
            box-shadow: 0 8px 20px rgba(22,136,248,.24);
        }
        .sidebar .brand-box small { color: #9bb1c9; letter-spacing: .12em; font-size: .61rem; margin-top: 3px; }
        .sidebar-nav {
            display: grid;
            flex: 1 1 auto;
            min-height: 0;
            gap: 22px;
            overflow-y: auto;
            padding: 0 2px 12px;
            scrollbar-width: thin;
            scrollbar-color: rgba(148,174,204,.35) transparent;
        }
        .sidebar .nav-group { display: grid; gap: 5px; }
        .sidebar .nav-group + .nav-group { padding-top: 0; margin-top: 0; border: 0; }
        .nav-section-label { margin: 0 0 5px 11px; color: #8299b3; font-size: .64rem; font-weight: 700; letter-spacing: .14em; text-transform: uppercase; }
        .sidebar .nav-item {
            position: relative;
            display: flex;
            align-items: center;
            gap: 12px;
            min-height: 44px;
            padding: 10px 12px;
            border: 1px solid transparent;
            border-radius: 11px;
            color: #c4d1e0;
            font-size: .91rem;
            font-weight: 550;
            transition: background .18s ease, color .18s ease, border-color .18s ease, transform .18s ease;
        }
        .sidebar .nav-item i { width: 19px; color: #8ea7c1; text-align: center; font-size: .95rem; transition: color .18s ease; }
        .sidebar .nav-item:hover, .sidebar .nav-item:focus-visible { background: rgba(255,255,255,.065); color: #fff; transform: translateX(2px); }
        .sidebar .nav-item:hover i, .sidebar .nav-item:focus-visible i { color: #75c8ff; }
        .sidebar .nav-item.active {
            background: linear-gradient(100deg, rgba(24,126,229,.26), rgba(33,156,190,.12));
            color: #fff;
            border-color: rgba(106,185,255,.2);
            box-shadow: inset 3px 0 #46b8ff, 0 6px 16px rgba(3,12,24,.12);
        }
        .sidebar .nav-item.active i { color: #76d7ff; }
        .sidebar-account { display: flex; align-items: center; gap: 11px; margin-top: auto; padding: 13px 11px; border: 1px solid rgba(255,255,255,.1); border-radius: 14px; background: rgba(255,255,255,.055); }
        .sidebar-account-avatar { display: grid; place-items: center; width: 38px; height: 38px; flex: 0 0 38px; border-radius: 12px; background: linear-gradient(145deg, #2377d4, #15a89d); color: #fff; font-size: .9rem; font-weight: 700; }
        .sidebar-account-copy { min-width: 0; }
        .sidebar-account-copy strong, .sidebar-account-copy span { display: block; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .sidebar-account-copy strong { color: #f3f7fc; font-size: .82rem; font-weight: 650; }
        .sidebar-account-copy span { margin-top: 3px; color: #9bb1c9; font-size: .7rem; }
        .sidebar .sidebar-footer { margin-top: 12px; padding: 4px 4px 0; border: 0; color: #8299b3; font-size: .68rem; text-align: center; }
        @media (max-width: 1100px) {
            .app-shell > .sidebar { width: 100%; height: auto; position: static; }
            .sidebar-nav { flex: initial; min-height: auto; grid-template-columns: repeat(2, minmax(0,1fr)); gap: 14px 22px; overflow: visible; }
            .sidebar-account { margin-top: 14px; }
        }
        @media (max-width: 560px) {
            .sidebar-nav { grid-template-columns: 1fr; gap: 14px; }
            .app-shell > .sidebar { padding: 18px 14px 14px; }
        }

        .defimap-theme-toggle {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            flex: 0 0 auto;
            min-height: 42px;
            padding: 0 14px;
            border: 1px solid rgba(125, 186, 255, .45);
            border-radius: 12px;
            color: #f4f8fc;
            background: #1456a0;
            box-shadow: 0 6px 16px rgba(5, 20, 38, .18);
            font: 600 14px/1 "Segoe UI", Arial, sans-serif;
            cursor: pointer;
            transition: transform .18s ease, box-shadow .18s ease;
        }
        .defimap-theme-toggle:hover { transform: translateY(-2px); box-shadow: 0 12px 28px rgba(5, 20, 38, .32); }
        .defimap-theme-toggle:focus-visible { outline: 3px solid #49bff0; outline-offset: 3px; }
        :root[data-theme="dark"] .defimap-theme-toggle { color: #102235; background: #ecf4fb; border-color: #c6d7e6; }
        .nav-links .defimap-theme-toggle { color: #f4f8fc; border-color: rgba(255,255,255,.3); }
        :root[data-theme="dark"] .nav-links .defimap-theme-toggle { color: #102235; border-color: #c6d7e6; }
        @media (max-width: 576px) { .defimap-theme-toggle { min-height: 40px; padding: 0 11px; } }
        @media (prefers-reduced-motion: reduce) {
            .defimap-theme-toggle { transition: none; }
        }
    </style>
    <script>
        (() => {
            let theme = 'light';
            try {
                const stored = localStorage.getItem('defimap-theme');
                if (stored === 'dark' || stored === 'light') theme = stored;
            } catch (error) {
                // Keep the default theme when browser storage is unavailable.
            }
            document.documentElement.dataset.theme = theme;
        })();
    </script>
    <?php
}

function defimap_theme_control(): void
{
    ?>
    <button class="defimap-theme-toggle" type="button" aria-pressed="false" aria-label="Switch to dark theme">
        <i class="fa-solid fa-moon" aria-hidden="true"></i>
        <span>Dark theme</span>
    </button>
    <script>
        (() => {
            const root = document.documentElement;
            const button = document.querySelector('.defimap-theme-toggle');
            if (!button) return;

            const updateButton = () => {
                const dark = root.dataset.theme === 'dark';
                button.setAttribute('aria-pressed', String(dark));
                button.setAttribute('aria-label', dark ? 'Switch to light theme' : 'Switch to dark theme');
                button.innerHTML = dark
                    ? '<i class="fa-solid fa-sun" aria-hidden="true"></i><span>Light theme</span>'
                    : '<i class="fa-solid fa-moon" aria-hidden="true"></i><span>Dark theme</span>';
            };

            button.addEventListener('click', () => {
                const theme = root.dataset.theme === 'dark' ? 'light' : 'dark';
                root.dataset.theme = theme;
                try {
                    localStorage.setItem('defimap-theme', theme);
                } catch (error) {
                    // The current page still changes theme if storage is unavailable.
                }
                updateButton();
            });
            updateButton();
        })();
    </script>
    <?php
}
?>