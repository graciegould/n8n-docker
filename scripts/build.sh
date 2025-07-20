#!/bin/bash

# Build script for n8n-docker project
set -e

echo "🔧 Building n8n-docker project..."

# Ensure data directory exists
echo "📁 Creating data directory if it doesn't exist..."
mkdir -p data

# Set proper permissions for the data directory
echo "🔐 Setting proper permissions..."
chmod 755 data

# Build the custom nodes if package.json exists
if [ -f "custom/package.json" ]; then
    echo "📦 Building custom nodes..."
    cd custom
    npm install
    npm run build
    cd ..
else
    echo "⚠️  No custom/package.json found, skipping custom node build"
fi

# Build Docker image
echo "🐳 Building Docker image..."
docker compose build

echo "✅ Build completed successfully!"
echo "🚀 To start the container, run: docker compose up -d" 