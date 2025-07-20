// Import all custom nodes
import { HelloWorld } from './nodes/HelloWorld/HelloWorld.node';

// Export all nodes for n8n
export const nodes = [
	HelloWorld,
];

// For CommonJS compatibility
module.exports = nodes; 