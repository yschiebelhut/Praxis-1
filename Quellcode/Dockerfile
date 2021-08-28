FROM node:lts-alpine AS build

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --production

FROM node:lts-alpine

WORKDIR /usr/src/app
COPY . .
COPY --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 8080
CMD [ "npm", "start" ]