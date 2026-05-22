# 9router-docker

Simple Docker setup for running 9Router on PaaS platforms.

## How this setup works

This repo expects you to place your exported 9Router SQLite database at:

```text
data.sqlite
```

During Docker build it copies the file into 9Router's data folder:

```text
/root/.9router/db/data.sqlite
```

Then it starts 9Router on the platform port.

## Files

```text
Dockerfile
README.md
.dockerignore
.gitignore
data.sqlite   # add this manually; ignored by git for safety
```

## Export from local Termux 9Router

On your phone/Termux:

```bash
pkill -f 9router || true
cp ~/.9router/db/data.sqlite ./data.sqlite
```

Upload or copy that `data.sqlite` into the PaaS/repo build context.

> Important: `data.sqlite` can contain provider tokens/API keys. Do not commit it to a public repo. This repo ignores `*.sqlite` by default.

## Dockerfile

```dockerfile
FROM node:20-slim

WORKDIR /app

RUN npm install -g 9router

RUN mkdir -p /root/.9router/db
COPY data.sqlite /root/.9router/db/data.sqlite

ENV PORT=7860
EXPOSE 7860

CMD ["sh", "-c", "9router --skip-update --no-browser --log -H 0.0.0.0 -p ${PORT:-7860}"]
```

## Test after deploy

```bash
curl https://YOUR-SERVICE-URL/v1/models
```

Expected: your 9Router combos such as `Modelmix`, `FastMini`, `Researcher`, `Coder`, `Reviewer`, and `Vision`.
