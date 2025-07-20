FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install any additional system packages if needed
# RUN apk add --no-cache package-name

# Create data directory and set proper permissions
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Switch back to node user
USER node 