FROM node:20-slim

WORKDIR /app

RUN npm install -g 9router

ENV PORT=7860
EXPOSE 7860

CMD ["sh", "-c", "mkdir -p /root/.9router/db && if [ -n \"$NINE_ROUTER_DB_SQLITE_B64\" ]; then printf \"%s\" \"$NINE_ROUTER_DB_SQLITE_B64\" | base64 -d > /root/.9router/db/data.sqlite; fi && if [ -n \"$NINE_ROUTER_JWT_SECRET\" ]; then printf \"%s\" \"$NINE_ROUTER_JWT_SECRET\" > /root/.9router/jwt-secret; fi && if [ -n \"$NINE_ROUTER_MACHINE_ID\" ]; then printf \"%s\" \"$NINE_ROUTER_MACHINE_ID\" > /root/.9router/machine-id; fi && 9router --skip-update --no-browser --log -H 0.0.0.0 -p ${PORT:-7860}"]
