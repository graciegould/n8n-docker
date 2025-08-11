#!/bin/bash

# Clear database script for n8n-docker project
set -e

echo "🗑️  Clearing n8n database..."

# Stop Docker container first
echo "🛑 Stopping Docker container..."
docker compose down

# Check if data directory exists
if [ -d "data" ]; then
    echo "📁 Removing data directory..."
    rm -rf data
    echo "✅ Data directory removed successfully!"
else
    echo "ℹ️  Data directory doesn't exist, nothing to clear"
fi

# Recreate data directory with proper permissions
echo "📁 Creating fresh data directory..."
mkdir -p data
chmod 755 data

echo "✅ Database cleared successfully!"
echo "💡 Run './scripts/start.sh' to start n8n with a fresh database"
