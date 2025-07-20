#!/bin/bash

# Start script for n8n-docker project
set -e

echo "🚀 Starting n8n-docker project..."

# Ensure data directory exists
echo "📁 Creating data directory if it doesn't exist..."
mkdir -p data

# Set proper permissions for the data directory
echo "🔐 Setting proper permissions..."
chmod 755 data

# Check if custom nodes need building
if [ -f "custom/package.json" ]; then
    echo "📦 Checking custom nodes..."
    if [ ! -d "custom/node_modules" ] || [ ! -d "custom/dist" ]; then
        echo "🔧 Building custom nodes..."
        cd custom
        npm install
        npm run build
        cd ..
    else
        echo "✅ Custom nodes already built"
    fi
fi

# Start Docker container
echo "🐳 Starting Docker container..."
docker compose up -d

echo "✅ n8n started successfully!"
echo "🌐 Access your n8n instance at: http://localhost:5678"
echo "👤 Username: admin"
echo "🔑 Password: password" 