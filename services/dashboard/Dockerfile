FROM node:24-alpine AS build
WORKDIR /app
COPY --from=src package.json package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY --from=src index.html vite.config.ts tsconfig.json tsconfig.app.json tsconfig.node.json ./
COPY --from=src public ./public
COPY --from=src src ./src
RUN npm run build

FROM nginx:1.29-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
