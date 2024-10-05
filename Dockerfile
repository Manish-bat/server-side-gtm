# Use an official Node runtime as a parent image
FROM node:18-alpine

# Install pnpm
RUN npm install -g pnpm

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and pnpm-lock.yaml (if available)
COPY package.json pnpm-lock.yaml* ./

# Copy the rest of your app's source code
COPY . .

# Install app dependencies
RUN pnpm run install:all

# Build the backend
RUN cd backend && pnpm run build

# Build the client
RUN cd client && pnpm run build

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["pnpm", "run", "start:prod"]