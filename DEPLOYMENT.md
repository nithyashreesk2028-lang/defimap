# DefiMap deployment

## Deploy on Render

This repository includes a Render Blueprint (`render.yaml`) and a Dockerfile for PHP 8.3 with Apache, `pdo_mysql`, and `mbstring`.

1. Push the repository to GitHub and make sure the required files are on the branch you intend to deploy.
2. In Render, choose **New → Blueprint**, connect this repository, and let Render read `render.yaml`. The Blueprint creates a Docker web service and asks you to provide the database values.
3. Create or choose an external MySQL database. Render does not provide a managed MySQL database. The database must accept connections from the Render service. Provide its hostname, database name, a dedicated non-root username, and a strong password when prompted. Keep credentials in Render environment settings; never put production values in `.env` or commit them.
4. Apply the schema and any required migrations to the external database using an administrative connection. The runtime database account should have only the permissions the application needs. See the SQL and migration files in the repository; do not grant schema/admin permissions to the web account.
5. Wait for the deployment to finish. Render's health check uses `/health.php`; it confirms Apache/PHP are responding and intentionally does not test the database.

The Blueprint configures `DEFIMAP_APP_ENV=production` and prompts for `DEFIMAP_DB_HOST`, `DEFIMAP_DB_NAME`, `DEFIMAP_DB_USER`, and `DEFIMAP_DB_PASSWORD`. Do not use `root` or a blank password. The Docker entrypoint configures Apache to listen on Render's `PORT` (defaulting to 10000 for local Docker use). The Apache configuration permits the repository's `.htaccess` security rules and recognizes HTTPS forwarded by Render.

## Important database setup

The app needs an external MySQL-compatible database; it cannot work fully until the database schema is created and its environment variables are set. Import the correct schema/migrations from the repository with an administrative account before testing login or other database-backed pages. Do not blindly import duplicate or `- Copy` SQL files—verify which schema matches the current application first. Never commit production credentials or a live `private/production.php` file.

The app's `.env` file is for local development only and is excluded from the Docker build context. The Render container filesystem is ephemeral, so do not store user uploads or other persistent data in the web service container. Use a persistent external service for any future uploaded files.

## Verify after deploy

- Open the Render service URL and confirm `/health.php` returns `{"status":"ok"}`.
- Test registration, sign-in/sign-out, and database-backed workflows.
- Confirm failed database connections show a generic application error and do not expose credentials.
- Check the Render logs and resolve any PHP or database errors before sharing the app publicly.
- Because this app handles health-related assessment data, review privacy, security, backups/retention, and the educational/non-diagnostic disclaimer before public use.

## Local Docker smoke test

```sh
docker build -t defimap .
docker run --rm -p 10000:10000 \
  -e PORT=10000 \
  -e DEFIMAP_APP_ENV=production \
  -e DEFIMAP_DB_HOST=host.docker.internal \
  -e DEFIMAP_DB_NAME=defimap \
  -e DEFIMAP_DB_USER=defimap_app \
  -e DEFIMAP_DB_PASSWORD='replace-me' \
  defimap
```

Then visit `http://localhost:10000/health.php`. The health route does not require the database, but the rest of the application does.
