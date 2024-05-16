# Use a base image with curl installed
FROM --platform=linux/amd64 ubuntu:20.04

# Set the working directory
WORKDIR /app

# Update the package list and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libc6 \
    && rm -rf /var/lib/apt/lists/*

# Download the Robocorp Action Server
RUN curl -o action-server https://downloads.robocorp.com/action-server/releases/latest/linux64/action-server && \
    chmod a+x action-server && \
    mv action-server /usr/local/bin/

# Copy the project files into the container
COPY . /app

# Expose the port the server runs on (assuming default port 8080)
EXPOSE 8050

# Start the server
CMD ["sh", "-c", "cd /app && action-server start --expose --port 8050 && netstat -tuln && ps aux"]