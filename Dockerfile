FROM searxng/searxng:latest

# Copy configuration
COPY ./searxng /etc/searxng

# Make sure the settings file is writable
RUN chmod 777 /etc/searxng/settings.yml

# Create an entrypoint script to handle environment variables
RUN echo '#!/bin/sh\n\
sed -i "s|\${REDIS_URL}|$REDIS_URL|g" /etc/searxng/settings.yml\n\
sed -i "s|xxxxx|$SEARXNG_SECRET_KEY|g" /etc/searxng/settings.yml\n\
exec "$@"' > /entrypoint.sh && \
chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/searxng/searx-run"]
