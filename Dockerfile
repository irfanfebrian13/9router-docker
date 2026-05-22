FROM node:20-slim

WORKDIR /app

RUN npm install -g 9router

ENV PORT=7860
EXPOSE 7860

CMD ["sh", "-c", "9router --skip-update --no-browser --log -H 0.0.0.0 -p ${PORT:-7860}"]
