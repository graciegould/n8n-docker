#!/bin/bash

# Development script for n8n-docker with hot reloading
set -e

echo "🚀 Starting N8N development mode with hot reloading..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Ensure data directory exists
print_status "Creating data directory if it doesn't exist..."
mkdir -p data
chmod 755 data

# Check if custom nodes need initial build
if [ -f "custom/package.json" ]; then
    print_status "Setting up custom nodes development environment..."
    cd custom
    
    # Install dependencies if node_modules doesn't exist
    if [ ! -d "node_modules" ]; then
        print_status "Installing custom node dependencies..."
        npm install
    fi
    
    # Initial build
    print_status "Performing initial build of custom nodes..."
    npm run build
    
    cd ..
else
    print_warning "No custom/package.json found, skipping custom node setup"
fi

# Start Docker container if not running
print_status "Checking Docker container status..."
if ! docker compose ps | grep -q "n8n.*Up"; then
    print_status "Starting Docker container..."
    docker compose up -d
    sleep 5  # Wait for container to start
else
    print_success "Docker container is already running"
fi

# Start custom node development in background
if [ -f "custom/package.json" ]; then
    print_status "Starting custom node development mode..."
    print_success "Custom nodes will automatically rebuild on file changes"
    print_success "N8N will automatically reload custom nodes"
    
    # Start Gulp development mode in background
    cd custom
    npm run dev &
    GULP_PID=$!
    cd ..
    
    print_success "Development mode started!"
    print_success "🌐 Access your n8n instance at: http://localhost:5678"
    print_success "👤 Username: admin"
    print_success "🔑 Password: password"
    print_status "Press Ctrl+C to stop development mode"
    
    # Function to cleanup on exit
    cleanup() {
        print_status "Stopping development mode..."
        if [ ! -z "$GULP_PID" ]; then
            kill $GULP_PID 2>/dev/null || true
        fi
        print_success "Development mode stopped"
        exit 0
    }
    
    # Trap Ctrl+C and cleanup
    trap cleanup SIGINT SIGTERM
    
    # Keep script running
    wait $GULP_PID
else
    print_success "N8N is running without custom nodes"
    print_success "🌐 Access your n8n instance at: http://localhost:5678"
    print_success "👤 Username: admin"
    print_success "🔑 Password: password"
    print_status "Press Ctrl+C to stop"
    
    # Keep script running
    while true; do
        sleep 1
    done
fi 