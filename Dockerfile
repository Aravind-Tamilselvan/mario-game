# Stage 1: Build
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json* ./
RUN npm install

# Copy source code
COPY . .

# Build the project (webpack)
RUN npm run start

# Stage 2: Serve
FROM node:18-alpine

WORKDIR /app

# Install a simple static server
RUN npm install -g http-server

# Copy built files from build stage
COPY --from=build /app/dist ./dist

# Expose port
EXPOSE 8080

# Run http-server
CMD ["http-server", "dist", "-p", "8080"]
