FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# Copy package.json and package-lock.json first (for caching)
COPY package*.json ./

RUN npm install

# Copy application source
COPY . .

EXPOSE 3000

ENV NODE_ENV=${NODE_ENV}

CMD ["npm", "run", "devStart"]
