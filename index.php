
<?php
require __DIR__ . DIRECTORY_SEPARATOR . 'bootstrap.php';

$returnDestinations = [
    'dashboard.php',
    'analysis.php',
    'reports.php',
    'tools.php?section=molecular',
    'tools.php?section=nutrition',
    'tools.php?section=reference',
    'tools.php?section=resources',
    'tools.php?section=settings',
];
$loginReturn = (string)($_POST['return'] ?? $_GET['return'] ?? '');
if (!in_array($loginReturn, $returnDestinations, true)
    && !preg_match('/^results\.php\?id=[1-9][0-9]*$/', $loginReturn)) {
    $loginReturn = 'dashboard.php';
}

if (isset($_SESSION['user_id'])) {
    header("Location: " . $loginReturn);
    exit();
}

$message = "";
$csrfValid = $_SERVER['REQUEST_METHOD'] !== 'POST'
    || defimap_csrf_valid((string)($_POST['csrf_token'] ?? ''));
if (!$csrfValid) {
    http_response_code(403);
    $message = "<div class='alert alert-danger'>Your session token is invalid. Refresh the page and try again.</div>";
}

/* ==========================
   USER REGISTRATION
========================== */
if (isset($_POST['register']) && $csrfValid) {
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    if (empty($name) || empty($email) || empty($password) || empty($confirm_password)) {
        $message = "<div class='alert alert-danger'>Please fill all fields.</div>";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $message = "<div class='alert alert-danger'>Invalid email address.</div>";
    } elseif (strlen($password) < 8) {
        $message = "<div class='alert alert-danger'>Use a password with at least 8 characters.</div>";
    } elseif ($password !== $confirm_password) {
        $message = "<div class='alert alert-danger'>Passwords do not match.</div>";
    } else {
        $check = $pdo->prepare("SELECT id FROM users WHERE email=?");
        $check->execute([$email]);

        if ($check->rowCount() > 0) {
            $message = "<div class='alert alert-warning'>Email already exists.</div>";
        } else {
            $hash = password_hash($password, PASSWORD_DEFAULT);
            $insert = $pdo->prepare("INSERT INTO users(name,email,password) VALUES(?,?,?)");

            if ($insert->execute([$name, $email, $hash])) {
                $message = "<div class='alert alert-success'>Registration successful. Please login.</div>";
            } else {
                $message = "<div class='alert alert-danger'>Registration failed.</div>";
            }
        }
    }
}

/* ==========================
   USER LOGIN
========================== */
if (isset($_POST['login']) && $csrfValid) {
    $email = trim($_POST['email']);
    $password = $_POST['password'];

    if (empty($email) || empty($password)) {
        $message = "<div class='alert alert-danger'>Please enter email and password.</div>";
    } else {
        $stmt = $pdo->prepare("SELECT * FROM users WHERE email=?");
        $stmt->execute([$email]);

        if ($stmt->rowCount() == 1) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if (password_verify($password, $user['password'])) {
                session_regenerate_id(true);
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['user_name'] = $user['name'];
                unset($_SESSION['csrf_token']);
                header("Location: " . $loginReturn);
                exit();
            } else {
                $message = "<div class='alert alert-danger'>Email or password is incorrect.</div>";
            }
        } else {
            $message = "<div class='alert alert-danger'>Email or password is incorrect.</div>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DefiMap | Nutrition, Genes & Health</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        :root {
            --navy: #0B1F3A;
            --navy-strong: #0A2348;
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
            --radius: 18px;
        }

        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(180deg, #edf4ff 0%, #f5f9ff 100%);
            color: var(--text);
        }

        a { text-decoration: none; }

        .topbar {
            position: sticky;
            top: 0;
            z-index: 20;
            background: rgba(11, 31, 58, 0.96);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }

        .topbar-inner {
            max-width: 1220px;
            margin: 0 auto;
            padding: 18px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #fff;
            min-width: 0;
        }

        .brand-mark {
            width: 44px;
            height: 44px;
            display: grid;
            place-items: center;
            border-radius: 14px;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.2);
            font-size: 1.2rem;
            color: #fff;
        }

        .brand-text {
            display: flex;
            flex-direction: column;
            line-height: 1.1;
        }

        .brand-text strong {
            font-size: 1.7rem;
            letter-spacing: -0.04em;
        }

        .brand-text span {
            font-size: 0.7rem;
            color: rgba(255,255,255,0.7);
            letter-spacing: 0.12em;
            text-transform: uppercase;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 18px;
            flex-wrap: wrap;
            margin-left: auto;
        }

        .nav-links a {
            color: rgba(255,255,255,0.8);
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .nav-links a:hover,
        .nav-links a:focus-visible {
            color: #fff;
            outline: none;
        }

        .hero {
            background: radial-gradient(circle at top left, rgba(22,119,232,0.18), transparent 30%), linear-gradient(135deg, var(--navy) 0%, #143d74 35%, #0d5cae 100%);
            color: #fff;
            overflow: hidden;
        }

        .hero-inner {
            max-width: 1220px;
            margin: 0 auto;
            padding: 56px 24px 72px;
            display: grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap: 32px;
            align-items: center;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 14px;
            border-radius: 999px;
            background: rgba(255,255,255,0.12);
            color: rgba(255,255,255,0.92);
            border: 1px solid rgba(255,255,255,0.18);
            font-size: 0.76rem;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        h1 {
            margin: 20px 0 12px;
            font-size: clamp(2.8rem, 4vw, 5rem);
            line-height: 1.04;
            letter-spacing: -0.06em;
            font-weight: 700;
        }

        .hero-copy p {
            margin: 0;
            font-size: 1.15rem;
            line-height: 1.7;
            max-width: 600px;
            color: rgba(255,255,255,0.82);
        }

        .cta-row {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            margin-top: 28px;
        }

        .primary-btn,
        .secondary-btn,
        .soft-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border-radius: 999px;
            border: none;
            font-weight: 700;
            padding: 14px 22px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .primary-btn {
            background: var(--action);
            color: #fff;
            box-shadow: 0 12px 24px rgba(22, 119, 232, 0.22);
        }

        .secondary-btn {
            background: rgba(255,255,255,0.12);
            color: #fff;
            border: 1px solid rgba(255,255,255,0.18);
        }

        .soft-btn {
            background: rgba(18,168,157,0.12);
            color: var(--primary);
            border: 1px solid rgba(20, 86, 160, 0.16);
        }

        .primary-btn:hover,
        .secondary-btn:hover,
        .soft-btn:hover,
        .primary-btn:focus-visible,
        .secondary-btn:focus-visible,
        .soft-btn:focus-visible {
            transform: translateY(-1px);
            outline: none;
        }

        .hero-card {
            background: rgba(255,255,255,0.06);
            border: 1px solid rgba(255,255,255,0.16);
            border-radius: 28px;
            box-shadow: var(--shadow);
            padding: 18px;
        }

        .mini-panel {
            background: rgba(255,255,255,0.97);
            color: var(--text);
            border-radius: 20px;
            padding: 22px;
            box-shadow: 0 14px 30px rgba(5, 18, 40, 0.12);
        }

        .mini-panel .label {
            color: var(--muted);
            font-size: 0.72rem;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            font-weight: 700;
        }

        .mini-panel h3 {
            margin: 10px 0 8px;
            font-size: 2rem;
            letter-spacing: -0.05em;
        }

        .metric-row {
            margin-top: 18px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .metric-box {
            padding: 14px 16px;
            border-radius: 14px;
            background: linear-gradient(180deg, #f6fbff, #edf4ff);
            border: 1px solid var(--border);
        }

        .metric-box strong {
            display: block;
            font-size: 1.5rem;
            letter-spacing: -0.05em;
            color: var(--navy);
        }

        .metric-box span {
            color: var(--muted);
            font-size: 0.85rem;
        }

        .section {
            max-width: 1220px;
            margin: 0 auto;
            padding: 72px 24px;
        }

        .section-header {
            display: flex;
            align-items: end;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 28px;
        }

        .section-header h2 {
            margin: 0;
            font-size: clamp(2rem, 2.6vw, 2.6rem);
            letter-spacing: -0.05em;
            color: var(--navy);
        }

        .section-header p {
            margin: 8px 0 0;
            color: var(--muted);
            max-width: 680px;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
        }

        .feature-card,
        .form-panel,
        .info-panel {
            background: rgba(255,255,255,0.9);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .feature-card {
            padding: 24px;
        }

        .feature-icon {
            width: 54px;
            height: 54px;
            border-radius: 16px;
            display: grid;
            place-items: center;
            font-size: 1.4rem;
            color: var(--primary);
            background: rgba(20, 86, 160, 0.08);
            margin-bottom: 18px;
        }

        .feature-card h3 {
            margin: 0 0 12px;
            font-size: 1.25rem;
            color: var(--navy);
        }

        .feature-card p {
            margin: 0;
            color: var(--muted);
            line-height: 1.7;
        }

        .auth-layout {
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 28px;
            align-items: start;
        }

        .form-panel {
            padding: 28px;
        }

        .form-panel h3 {
            margin: 0 0 24px;
            color: var(--navy);
            font-weight: 700;
            font-size: 1.8rem;
            letter-spacing: -0.04em;
        }

        .auth-form .form-label {
            font-weight: 600;
            color: var(--navy);
        }

        .auth-form .form-control {
            height: 52px;
            border-radius: 14px;
            border: 1px solid var(--border);
            padding: 0 16px;
            background: #fbfdff;
            color: var(--text);
        }

        .auth-form .form-control:focus,
        .auth-form .form-control:focus-visible {
            border-color: rgba(22,119,232,0.52);
            box-shadow: 0 0 0 0.2rem rgba(22,119,232,0.12);
            outline: none;
        }

        .auth-form .btn {
            width: 100%;
            height: 52px;
            border-radius: 14px;
            font-weight: 700;
        }

        .info-panel {
            padding: 28px;
            background: linear-gradient(180deg, #ffffff, #f5f9ff);
        }

        .info-panel ul {
            list-style: none;
            padding: 0;
            margin: 18px 0 0;
            display: grid;
            gap: 16px;
        }

        .info-panel li {
            display: flex;
            align-items: start;
            gap: 12px;
            color: var(--muted);
            line-height: 1.6;
        }

        .info-panel li i {
            color: var(--teal);
            margin-top: 3px;
        }

        .notice {
            border-radius: 14px;
            padding: 14px 16px;
            margin-bottom: 18px;
            font-weight: 600;
        }

        .notice.alert-success {
            background: rgba(18, 168, 157, 0.09);
            color: #0e7a70;
            border: 1px solid rgba(18,168,157,0.2);
        }

        .notice.alert-danger {
            background: rgba(220, 53, 69, 0.06);
            color: #b42318;
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        .notice.alert-warning {
            background: rgba(255, 193, 7, 0.1);
            color: #8a5b00;
            border: 1px solid rgba(255, 193, 7, 0.25);
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, rgba(220,231,243,0), rgba(220,231,243,1), rgba(220,231,243,0));
            margin: 18px 0 8px;
        }

        .inline-note {
            text-align: center;
            color: var(--muted);
            font-size: 0.93rem;
            margin-top: 10px;
        }

        .disclaimer {
            background: rgba(255,255,255,0.75);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 22px 24px;
            color: var(--muted);
            line-height: 1.8;
        }

        .disclaimer strong {
            color: var(--navy);
        }

        footer {
            background: var(--navy);
            color: rgba(255,255,255,0.88);
            padding: 24px 20px;
            text-align: center;
        }

        @media (max-width: 1024px) {
            .hero-inner,
            .auth-layout {
                grid-template-columns: 1fr;
            }

            .feature-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 768px) {
            .topbar-inner {
                padding: 14px 16px;
            }

            .brand-text strong {
                font-size: 1.2rem;
            }

            .nav-links {
                gap: 10px;
                font-size: 0.9rem;
            }

            .section,
            .hero-inner {
                padding-left: 16px;
                padding-right: 16px;
            }

            .feature-grid {
                grid-template-columns: 1fr;
            }

            .section-header {
                display: block;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation: none !important;
                transition: none !important;
                scroll-behavior: auto !important;
            }
        }
    </style>
    <?php defimap_theme_head(); ?>
</head>
<body>
    <header class="topbar">
        <div class="topbar-inner">
            <div class="brand" aria-label="DefiMap home">
                <div class="brand-mark"><i class="fa-solid fa-dna"></i></div>
                <div class="brand-text">
                    <strong>DefiMap</strong>
                    <span>Nutrition · Genes · Health</span>
                </div>
            </div>
            <nav class="nav-links" aria-label="Main navigation">
                <a href="#top">Home</a>
                <a href="#about">About</a>
                <a href="#features">Features</a>
                <a href="#login">Login</a>
                <a href="#register">Register</a>
                <?php defimap_theme_control(); ?>
            </nav>
        </div>
    </header>

    <main>
        <section class="hero" id="top">
            <div class="hero-inner">
                <div class="hero-copy">
                    <div class="eyebrow"><i class="fa-solid fa-shield-heart"></i> Research-grade nutritional intelligence</div>
                    <h1>DefiMap</h1>
                    <p>Explore possible nutritional deficiency patterns using symptoms, dietary habits, health indicators and curated molecular evidence.</p>
                    <div class="cta-row">
                        <a class="primary-btn" href="#register"><i class="fa-solid fa-arrow-right"></i> Start analysis</a>
                        <a class="secondary-btn" href="#features"><i class="fa-solid fa-circle-info"></i> Platform overview</a>
                    </div>
                </div>
                <div class="hero-card" aria-label="DefiMap overview panel">
                    <div class="mini-panel">
                        <div class="label">Clinical evidence snapshot</div>
                        <h3>Precision nutrition</h3>
                        <div class="metric-row">
                            <div class="metric-box">
                                <strong>6+</strong>
                                <span>Nutrient domains</span>
                            </div>
                            <div class="metric-box">
                                <strong>30+</strong>
                                <span>Curated markers</span>
                            </div>
                            <div class="metric-box">
                                <strong>120+</strong>
                                <span>Gene links</span>
                            </div>
                            <div class="metric-box">
                                <strong>24/7</strong>
                                <span>Research context</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section" id="about">
            <div class="section-header">
                <div>
                    <h2>About DefiMap</h2>
                    <p>DefiMap is designed for evidence-informed nutrition and health research workflows, helping users investigate possible deficiency patterns using symptoms, dietary intake, biomarkers and related molecular associations.</p>
                </div>
            </div>
        </section>

        <section class="section" id="features">
            <div class="section-header">
                <div>
                    <h2>Platform capabilities</h2>
                    <p>Built around a trust-first research workflow to support careful interpretation rather than automated diagnosis.</p>
                </div>
            </div>
            <div class="feature-grid">
                <article class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-heart-pulse"></i></div>
                    <h3>Nutritional analysis</h3>
                    <p>Assess user-reported symptoms and dietary patterns against curated deficiency relationships.</p>
                </article>
                <article class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-dna"></i></div>
                    <h3>Molecular mapping</h3>
                    <p>Explore gene, protein and pathway associations which may support hypothesis generation and interpretation.</p>
                </article>
                <article class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
                    <h3>History & comparison</h3>
                    <p>Review prior assessments and compare reported factors over time while preserving user ownership checks.</p>
                </article>
                <article class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-utensils"></i></div>
                    <h3>Food mapping</h3>
                    <p>Connect dietary intake records with important nutrient sources and commonsense food choices.</p>
                </article>
                <article class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-chart-line"></i></div>
                    <h3>Explainable results</h3>
                    <p>Present the information used by the assessment in a structured and transparent format.</p>
                </article>
                <article class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-book"></i></div>
                    <h3>Scientific references</h3>
                    <p>Direct users to official sources such as NCBI Gene, UniProt, Reactome and PubMed where available.</p>
                </article>
            </div>
        </section>

        <section class="section">
            <div class="auth-layout">
                <div class="form-panel" id="login">
                    <h3>Login</h3>
                    <?php echo $message; ?>
                    <form method="POST" class="auth-form">
                        <input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars(defimap_csrf_token(), ENT_QUOTES, 'UTF-8'); ?>">
                        <input type="hidden" name="return" value="<?php echo htmlspecialchars($loginReturn, ENT_QUOTES, 'UTF-8'); ?>">
                        <div class="mb-3">
                            <label class="form-label" for="login-email">Email address</label>
                            <input id="login-email" type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="login-password">Password</label>
                            <input id="login-password" type="password" name="password" class="form-control" required>
                        </div>
                        <button type="submit" name="login" class="btn btn-primary">
                            <i class="fa-solid fa-right-to-bracket"></i> Login
                        </button>
                    </form>
                    <div class="divider"></div>
                    <div class="inline-note">Need an account? Create one in the form to the right.</div>
                </div>

                <div class="form-panel" id="register">
                    <h3>Create account</h3>
                    <form method="POST" class="auth-form">
                        <input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars(defimap_csrf_token(), ENT_QUOTES, 'UTF-8'); ?>">
                        <div class="mb-3">
                            <label class="form-label" for="register-name">Full name</label>
                            <input id="register-name" type="text" name="name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="register-email">Email address</label>
                            <input id="register-email" type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="register-password">Password</label>
                            <input id="register-password" type="password" name="password" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="register-confirm">Confirm password</label>
                            <input id="register-confirm" type="password" name="confirm_password" class="form-control" required>
                        </div>
                        <button type="submit" name="register" class="btn btn-success">
                            <i class="fa-solid fa-user-plus"></i> Register
                        </button>
                    </form>
                </div>
            </div>
        </section>

        <section class="section" style="padding-top:0;">
            <div class="disclaimer">
                <strong>Educational disclaimer:</strong> DefiMap is an educational and research-oriented platform. Results are based on user-reported information, dietary patterns, and curated biological associations. It does not diagnose disease, prescribe treatment, or replace professional clinical assessment. Laboratory testing and qualified medical review remain necessary for confirmation.
            </div>
        </section>
    </main>

    <footer>
        <div>© 2026 DefiMap | Nutritional deficiency discovery and molecular interpretation</div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
