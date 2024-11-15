FROM searxng/searxng:latest

# Copy configuration to the correct path
COPY ./searx /etc/searx

# Make sure the settings file is writable
RUN chmod 777 /etc/searx/settings.yml

# Create entrypoint script properly
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'sed -i "s|\${REDIS_URL}|$REDIS_URL|g" /etc/searx/settings.yml' >> /entrypoint.sh && \
    echo 'sed -i "s|xxxxx|$SEARXNG_SECRET_KEY|g" /etc/searx/settings.yml' >> /entrypoint.sh && \
    echo 'exec "$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["python", "-m", "searx.webapp"]
