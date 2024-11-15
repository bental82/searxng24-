# Dockerfile
FROM searxng/searxng:latest

# Copy any custom configuration if needed
COPY ./searxng /etc/searxng

# Expose the port
EXPOSE 8080

# The command will be inherited from the base image
