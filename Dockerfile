FROM node:20-bullseye

WORKDIR /app

ENV NODE_ENV=production
ENV PUPPETEER_SKIP_DOWNLOAD=true

# system deps needed for rammerhead + puppeteer
RUN apt-get update && apt-get install -y \
  tor \
  bash \
  ca-certificates \
  curl \
  git \
  python3 \
  make \
  g++ \
  && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 8080

CMD ["node", "backend.js"]
