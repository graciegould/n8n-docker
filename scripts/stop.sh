#!/bin/bash

# Stop script for n8n-docker project
set -e

echo "🛑 Stopping n8n-docker project..."

# Stop Docker container
echo "🐳 Stopping Docker container..."
docker compose down

echo "✅ n8n stopped successfully!" 