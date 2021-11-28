# ---- Base Node ----
FROM alpine:3.14 AS base
LABEL maintainer "Sohel Tarir <sohel.tarir@gmail.com>"
# install node
RUN apk add --no-cache nodejs tini git npm
# set working directory
WORKDIR /app
# Set tini as entrypoint
ENTRYPOINT ["/sbin/tini", "--"]
# copy project file
COPY package.json .

# ---- Dependencies ----
FROM base AS dependencies
# install node packages
RUN npm set progress=false && npm config set depth 0
RUN npm install

# ---- Release ----
FROM base AS release
# copy production node_modules
COPY --from=dependencies /app/node_modules ./node_modules
# copy app sources
COPY app.js .
RUN apk del git npm
# expose port and define CMD
EXPOSE 3000
CMD ["node", "app.js"]
