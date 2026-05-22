FROM node:20-slim

WORKDIR /app

RUN npm install -g 9router

RUN mkdir -p /root/.9router/db
COPY data.sqlite /root/.9router/db/data.sqlite

ENV PORT=7860
EXPOSE 7860

CMD ["sh", "-c", "9router --skip-update --no-browser --log -H 0.0.0.0 -p ${PORT:-7860}"]
