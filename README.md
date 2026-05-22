# 9router-docker

Docker setup for running [9Router](https://www.npmjs.com/package/9router) on PaaS platforms such as Render, Railway, Koyeb, Fly.io, or Hugging Face Docker Spaces.

## What this image does

- Installs `9router` globally with npm.
- Runs it as a public HTTP service.
- Binds to `0.0.0.0`.
- Uses the platform `PORT` env var when available.
- Optionally restores your existing 9Router SQLite config from environment secrets.

## Environment variables

| Name | Required | Description |
| --- | --- | --- | --- |
| `PORT` | Usually provided by PaaS | Port to run 9Router on. Defaults to `7860`. |
| `NINE_ROUTER_DB_SQLITE_B64` | Optional | Base64-encoded copy of `~/.9router/db/data.sqlite`. Restores providers, combos, API keys, etc. |
| `NINE_ROUTER_JWT_SECRET` | Optional | Contents of `~/.9router/jwt-secret`. Helps preserve dashboard/session signing. |
| `NINE_ROUTER_MACHINE_ID` | Optional | Contents of `~/.9router/machine-id`. |

## Export your local 9Router config

On the device where 9Router is already configured:

```bash
# optional: stop local 9Router briefly for a cleaner SQLite snapshot
pkill -f 9router || true

base64 -w 0 ~/.9router/db/data.sqlite
cat ~/.9router/jwt-secret
cat ~/.9router/machine-id
```

Copy the outputs into your PaaS secret/environment variable panel. Do **not** commit these values to GitHub.

## Test after deployment

Replace the URL with your deployed service URL:

```bash
curl https://your-service.example.com/v1/models
```

Expected result: JSON containing your combo names such as `Modelmix`, `FastMini`, `Researcher`, `Coder`, `Reviewer`, or `Vision`.

## Hermes config example

```bash
hermes config set model.base_url https://your-service.example.com/v1
```

If you have auxiliary models configured, update their `base_url` values too.

## Notes

- Free PaaS services often sleep when idle. First request after idle can be slow.
- Keep the repository private if you ever accidentally add config files.
- This repo intentionally ignores `.sqlite`, `.env`, and `.9router` files.
