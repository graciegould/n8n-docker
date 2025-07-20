# N8N Docker Project

A Docker-based N8N setup with custom nodes and local-only data storage.

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Node.js (for custom node development)

### Using Scripts (Recommended)

```bash
# Development mode with hot reloading
./scripts/dev.sh

# Build and start everything
./scripts/start.sh

# Stop the container
./scripts/stop.sh

# Full rebuild
./scripts/build.sh
```

### Manual Setup

```bash
# Create data directory
mkdir -p data

# Build custom nodes
cd custom && npm install && npm run build && cd ..

# Start container
docker compose up -d
```

## 📁 Project Structure

```
n8n-docker/
├── data/                  # Local N8N data storage (gitignored)
├── custom/               # Custom N8N nodes
│   ├── src/             # TypeScript source files
│   ├── dist/            # Compiled JavaScript
│   ├── package.json     # Node.js dependencies
│   └── tsconfig.json    # TypeScript configuration
├── scripts/             # Build and management scripts
│   ├── build.sh         # Full build process
│   ├── start.sh         # Start with checks
│   ├── stop.sh          # Stop container
│   ├── dev.sh           # Development mode with hot reload
├── requirements.txt     # Python dependencies
├── docker-compose.yml   # Docker orchestration
├── Dockerfile           # Container configuration
└── README.md           # This file
```

## 🔧 Configuration

### Environment Variables
- **N8N_BASIC_AUTH_USER**: `admin`
- **N8N_BASIC_AUTH_PASSWORD**: `password`
- **N8N_HOST**: `localhost`
- **N8N_PORT**: `5678`

### Local Data Storage
All N8N data (workflows, credentials, execution history) is stored locally in the `data/` directory. This ensures:
- No cloud dependencies
- Complete data privacy
- Easy backup and migration

### Python Dependencies
Python and pip are installed in the container. Dependencies are managed via `requirements.txt`:
- **BeautifulSoup4**: Web scraping and HTML parsing
- **Requests**: HTTP library for API calls
- **lxml**: Fast XML/HTML parser
- **html5lib**: HTML5 parser

To add new Python dependencies:
1. Edit `requirements.txt`
2. Rebuild the Docker image: `docker compose build --no-cache`
3. Restart the container: `docker compose restart`

## 🛠️ Development

### Development Mode (Recommended)
```bash
# Start development mode with "hot" reloading
./scripts/dev.sh
```

This will:
- Start the N8N container
- Watch for changes in `custom/src/`
- Automatically rebuild custom nodes using SWC
- N8N will automatically reload custom nodes

### Manual Custom Node Development
1. Edit files in `custom/src/`
2. Build with `npm run build` (in `custom/` directory)
3. Restart container: `docker compose restart`

### Adding New Custom Nodes
1. Create new node file in `custom/src/nodes/`
2. Export from `custom/src/index.ts`
3. Build and restart

## 📝 Scripts

### `./scripts/start.sh`
- Creates data directory if missing
- Builds custom nodes if needed
- Starts Docker container
- Shows access information

### `./scripts/stop.sh`
- Stops Docker container
- Cleans up resources

### `./scripts/dev.sh`
- Starts development mode with hot reloading
- Watches for changes in custom nodes
- Automatically rebuilds using SWC
- Manages Docker container lifecycle

### `./scripts/build.sh`
- Creates data directory
- Installs and builds custom nodes
- Builds Docker image
- Sets proper permissions

### `./scripts/test-python.sh`
- Tests Python installation
- Verifies BeautifulSoup and other dependencies
- Shows installed package versions

## 🔒 Security

- All data stored locally
- No telemetry or cloud features enabled
- Basic authentication enabled
- Sensitive files gitignored

## 🌐 Access

- **URL**: http://localhost:5678
- **Username**: `admin`
- **Password**: `password`

## 🐛 Troubleshooting

### Container won't start
```bash
# Check logs
docker compose logs

# Rebuild from scratch
./scripts/build.sh
./scripts/start.sh
```

### Custom nodes not loading
```bash
# Rebuild custom nodes
cd custom && npm run build && cd ..

# Restart container
docker compose restart
```

### Permission issues
```bash
# Fix data directory permissions
chmod 755 data
```
