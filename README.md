# 9router-docker

Simple Docker setup for running 9Router on PaaS platforms.

## Recommended migration flow

The easiest way to migrate an existing 9Router setup is **not** to manually copy the raw SQLite database.

Use 9Router's built-in migration/export feature instead:

1. Open the 9Router instance that already has your providers, combos, and settings.
2. Download/export the migration or backup file from that old/current 9Router.
3. Deploy a fresh 9Router using this Docker image.
4. Open the new 9Router dashboard.
5. Import the migration/backup file into the new 9Router.
6. Test the OpenAI-compatible endpoint:

```bash
curl https://YOUR-SERVICE-URL/v1/models
```

Expected result: your migrated 9Router combos such as `Modelmix`, `FastMini`, `Researcher`, `Coder`, `Reviewer`, and `Vision`.

## Dockerfile

```dockerfile
FROM node:20-slim

WORKDIR /app

RUN npm install -g 9router

ENV PORT=7860
EXPOSE 7860

CMD ["sh", "-c", "9router --skip-update --no-browser --log -H 0.0.0.0 -p ${PORT:-7860}"]
```

## Deploy steps

Use this repository as the source for your PaaS service.

Typical settings:

- Runtime: Docker
- Port: use the platform-provided `PORT`, fallback `7860`
- Start command: already defined in `Dockerfile`

After deploy, open:

```text
https://YOUR-SERVICE-URL
```

Login with the default 9Router password if you have not changed it yet, then import your migration/backup file through the dashboard.

## Hermes config example

After the new 9Router endpoint works, update Hermes to use it:

```bash
hermes config set model.base_url https://YOUR-SERVICE-URL/v1
```

If you use Hermes auxiliary models, update those `base_url` values too.

## Notes

- Do not commit raw database files, API keys, migration backups, or `.env` files to this repo.
- Free PaaS services can sleep when idle. First request after idle may be slow.
- Keep your migration/backup file private because it may contain provider credentials or API tokens.
