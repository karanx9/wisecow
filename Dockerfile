# Build the Angular app
FROM node:14 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Serve the built app with Node.js
FROM node:14-alpine
WORKDIR /app
COPY --from=build /app/dist /app
COPY package*.json ./
RUN npm install --only=production
EXPOSE 4200
CMD ["npm", "start"]
