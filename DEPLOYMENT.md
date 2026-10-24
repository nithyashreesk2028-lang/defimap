# DefiMap deployment checklist

This project includes a local XAMPP `.env` file and a `.env.example`
template. The real `.env` is excluded from Git and blocked over HTTP. A public
deployment must use explicit production environment variables and a dedicated,
least-privilege MySQL account. Never deploy with XAMPP's `root` account or a
blank database password.

## 1. Configure the application environment

Set these variables in the hosting control panel, PHP-FPM pool, container, or
web-server service environment. Hosting environment variables take precedence
over `.env`. Do not put production credentials in PHP source control or a
web-accessible `.env` file:

```text
DEFIMAP_APP_ENV=production
DEFIMAP_DB_HOST=127.0.0.1
DEFIMAP_DB_NAME=defimap
DEFIMAP_DB_USER=defimap_app
DEFIMAP_DB_PASSWORD=<long-random-secret>
```

The app refuses to connect in production if the database user is `root`, the
password is empty, or any required database setting is missing. When
`DEFIMAP_APP_ENV` is unset, CLI and localhost development requests use
development defaults; requests for non-local server names default to
production. On non-local hosts, production mode cannot be downgraded by
`DEFIMAP_APP_ENV=development` from a `.env` file. Production database
credentials must come from the hosting process environment, not `.env`.
Local web development is recognized only when the server address and client
address are loopback addresses as well as the host name being local; this
prevents a public request from selecting development mode just by supplying a
`localhost` Host header. Set the environment explicitly in both environments.

For local XAMPP, the included `.env` is configured for the existing local
`defimap` database and a generated local-only account. Edit it only if your
local MySQL settings differ. Never copy this local account to a public server.

Create a dedicated MySQL account with only the permissions the running app
needs. Do not use that account for schema changes or imports. Run migrations
and dataset import scripts separately using an administrative account, then
remove or disable that account's credentials from the web runtime.

For MySQL, create the runtime account with scoped permissions like these,
replacing the password and database host for your provider:

```sql
CREATE USER 'defimap_app'@'localhost' IDENTIFIED BY 'replace-with-a-long-random-secret';
GRANT SELECT, INSERT, UPDATE ON defimap.* TO 'defimap_app'@'localhost';
```

## 2. Configure HTTPS and Apache

- Serve the site only over HTTPS and enable automatic HTTP-to-HTTPS
  redirection at the web server or hosting provider.
- Make sure PHP receives the HTTPS request state so secure session cookies
  and HSTS are enabled. HSTS is sent only on HTTPS requests.
- Point the web root at this application directory, or preferably at a
  dedicated public directory if the hosting layout supports it.
- Ensure Apache `mod_rewrite` is not required and that `.htaccess` overrides
  are permitted. The root rules disable directory listings and block SQL,
  documentation, archive, batch, and environment files. `data/` and
  `datasets/` are denied over HTTP; command-line importers continue to work.
- Use a supported PHP release with `pdo_mysql`, `mbstring`, and HTTPS enabled.
- Keep PHP error display disabled in production and route PHP/server logs to a
  location not served by the web server.

The app sends baseline browser security headers and uses strict, HTTP-only,
SameSite session cookies. CSRF tokens protect login, registration,
assessment submission, account settings, and logout. Secure cookies and HSTS
are enabled when production PHP requests are marked HTTPS.

## 3. Prepare and deploy the database

1. Back up the database and verify that the backup can be restored.
2. Create the production database and least-privilege runtime account.
3. Apply reviewed schema migrations with an administrative account.
4. Import datasets using the CLI-only scripts and run the validators.
5. Deploy application files without local secrets, database dumps, or
   temporary exports. Exclude `.env` from deployment bundles even though HTTP
   rules block it.
6. Confirm that direct HTTP requests to `/datasets/` and `/data/` are denied.
7. Verify that the live site redirects to HTTPS and sets a `Secure`,
   `HttpOnly`, `SameSite=Lax` session cookie.

## 4. Smoke-test before opening access

- Register, sign in, and sign out.
- Submit an assessment, open its result, and revisit it from reports/history.
- Confirm that one account cannot access another account's report.
- Submit forms with missing or invalid CSRF tokens and confirm they are
  rejected without changing data.
- Confirm that database failures return a generic message while details go
  only to server logs.
- Verify the dataset validator and check import counts against the release
  being deployed.

## Remaining production work

These configuration changes are a production baseline, not a guarantee of
production readiness. Before a public launch, complete a code review and
security test, decide on backups/retention and privacy disclosures for health
information, review external CDN dependencies and add an appropriate Content
Security Policy, test on the actual hosting provider, and have the
scientific/clinical limitations reviewed. The assessment is informational
only and is not a medical diagnosis.
