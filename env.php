<?php

$defimapEnvironmentFileKeys = [];
$environmentFile = __DIR__ . DIRECTORY_SEPARATOR . '.env';
if (is_file($environmentFile)) {
    $environmentLines = file($environmentFile, FILE_IGNORE_NEW_LINES);
    if ($environmentLines === false) {
        throw new RuntimeException('Unable to read the DefiMap environment file.');
    }

    foreach ($environmentLines as $lineNumber => $line) {
        $line = trim($line);
        if ($line === '' || str_starts_with($line, '#')) {
            continue;
        }

        if (!preg_match('/^([A-Z][A-Z0-9_]*)=(.*)$/', $line, $matches)) {
            throw new RuntimeException('Invalid DefiMap environment setting on line ' . ($lineNumber + 1) . '.');
        }

        $key = $matches[1];
        $value = trim($matches[2]);
        if (strlen($value) >= 2
            && (($value[0] === '"' && substr($value, -1) === '"')
                || ($value[0] === "'" && substr($value, -1) === "'"))) {
            $value = substr($value, 1, -1);
        }

        if (getenv($key) === false) {
            putenv($key . '=' . $value);
            $_ENV[$key] = $value;
            $defimapEnvironmentFileKeys[] = $key;
        }
    }
}

function defimap_environment(): string
{
    global $defimapEnvironmentFileKeys;

    $serverName = strtolower((string)($_SERVER['SERVER_NAME'] ?? 'localhost'));
    $localAddresses = ['127.0.0.1', '::1'];
    $serverAddress = (string)($_SERVER['SERVER_ADDR'] ?? '');
    $remoteAddress = (string)($_SERVER['REMOTE_ADDR'] ?? '');
    $localName = in_array($serverName, ['localhost', '127.0.0.1', '::1'], true)
        || preg_match('/(?:^|\.)localhost$/', $serverName) === 1
        || preg_match('/(?:^|\.)test$/', $serverName) === 1;
    $hasRequestAddresses = $serverAddress !== '' || $remoteAddress !== '';
    $isLocalHost = (PHP_SAPI === 'cli' && !$hasRequestAddresses)
        || ($localName
            && in_array($serverAddress, $localAddresses, true)
            && in_array($remoteAddress, $localAddresses, true));
    $environment = getenv('DEFIMAP_APP_ENV');

    if (!$isLocalHost && in_array('DEFIMAP_APP_ENV', $defimapEnvironmentFileKeys, true)) {
        return 'production';
    }

    if ($environment === false || $environment === '') {
        return $isLocalHost ? 'development' : 'production';
    }

    return $environment;
}
