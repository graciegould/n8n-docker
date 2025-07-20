# Custom N8N Nodes

This directory contains custom N8N nodes and extensions for the n8n-docker project.

## Structure

```
custom/
├── src/                   # TypeScript source files
│   ├── index.ts           # Main entry point
│   └── nodes/             # Custom node implementations
├── dist/                  # Compiled JavaScript (generated)
├── scripts/               # Utility scripts
├── package.json           # Node.js dependencies
├── tsconfig.json          # TypeScript configuration
└── README.md              # This file
```

## Development

### Setup

1. Install dependencies:
   ```bash
   cd custom
   npm install
   ```

2. Build the project:
   ```bash
   npm run build
   ```

3. For development with auto-rebuild:
   ```bash
   npm run dev
   ```

### Adding Custom Nodes

1. Create a new node file in `src/nodes/`
2. Export your node from `src/index.ts`
3. Build the project
4. Restart the N8N container

### Available Scripts

- `npm run build` - Compile TypeScript to JavaScript
- `npm run dev` - Watch mode for development
- `npm run test` - Run tests
- `npm run lint` - Lint TypeScript files
- `npm run clean` - Remove build artifacts

## Docker Integration

The custom directory is mounted into the N8N container at `/home/node/.n8n/custom`. Any changes to the source files will be reflected in the container after rebuilding.

## Best Practices

- Keep node implementations in `src/nodes/`
- Use TypeScript for type safety
- Follow N8N's node development guidelines
- Test your nodes thoroughly
- Document your nodes with clear descriptions and examples 