FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install Python and pip
RUN apk add --no-cache python3 py3-pip

# Create data directory and set proper permissions
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Copy requirements file
COPY requirements.txt /tmp/requirements.txt

# Install Python packages
RUN pip3 install --break-system-packages -r /tmp/requirements.txt

# Clean up
RUN rm -f /tmp/requirements.txt

# Switch back to node user
USER node 