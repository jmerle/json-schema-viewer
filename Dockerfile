FROM node:18.12.1 AS build

WORKDIR /app

COPY . .

RUN --mount=type=cache,target=/root/.yarn YARN_CACHE_FOLDER=/root/.yarn yarn
RUN yarn gen-schema
RUN yarn build-prod

FROM adasupport/nginx-spa:1.21.7

COPY --from=build /app/dist /app
