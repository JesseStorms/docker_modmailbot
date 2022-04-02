FROM node:14 AS build
COPY ./modmailbot /bot
WORKDIR /bot
RUN npm ci

FROM node:16-alpine
COPY --from=build /bot /bot
WORKDIR /bot
RUN apk add git
CMD npm start
