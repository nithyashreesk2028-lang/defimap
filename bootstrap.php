<?php
require_once __DIR__ . DIRECTORY_SEPARATOR . 'env.php';

$appEnvironment = defimap_environment();

ini_set('display_errors', $appEnvironment === 'production' ? '0' : '1');
ini_set('log_errors', '1');

header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: SAMEORIGIN');
header('Referrer-Policy: strict-origin-when-cross-origin');
header('Permissions-Policy: camera=(), microphone=(), geolocation=()');
header('Cross-Origin-Opener-Policy: same-origin');

if ($appEnvironment === 'production') {
    header('Cache-Control: no-store, private');
    if (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') {
        header('Strict-Transport-Security: max-age=31536000');
    }
}

ini_set('session.use_strict_mode', '1');
ini_set('session.use_only_cookies', '1');
ini_set('session.cookie_httponly', '1');
ini_set('session.cookie_secure', $appEnvironment === 'production' ? '1' : '0');
session_set_cookie_params([
    'lifetime' => 0,
    'path' => '/',
    'secure' => $appEnvironment === 'production',
    'httponly' => true,
    'samesite' => 'Lax',
]);

if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}

require_once __DIR__ . DIRECTORY_SEPARATOR . 'db.php';

function defimap_csrf_token(): string
{
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }

    return $_SESSION['csrf_token'];
}

function defimap_csrf_valid(string $submittedToken): bool
{
    return isset($_SESSION['csrf_token'])
        && $submittedToken !== ''
        && hash_equals($_SESSION['csrf_token'], $submittedToken);
}
