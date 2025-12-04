# Use Node.js 20 slim base image for smaller size
FROM node:20-slim
LABEL maintainer="it241512@ustp-students.at"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade system packages
RUN apt update && apt upgrade -y

RUN apt install -y curl

# Set working directory for the application
WORKDIR /usr/src/app

# Install global npm packages needed for the application
RUN npm i -g npm@11 typeorm

# Copy package files first for better Docker layer caching
COPY package*json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application source code
COPY . .

# Build the application (compiles TypeScript, bundles assets, etc.)
RUN npm run build