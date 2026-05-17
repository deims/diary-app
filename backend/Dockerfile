# backend/Dockerfile
FROM php:8.2-cli-alpine

# Install SQLite
RUN apk add --no-cache sqlite sqlite-dev composer && \
    docker-php-ext-install pdo_sqlite


# Set working directory
WORKDIR /var/www/app

# Copy all backend files
COPY . /var/www/app/

RUN composer install

# Create database directory and set permissions
RUN mkdir -p /var/www/app/database && chmod 777 /var/www/app/database
RUN sqlite3 /var/www/app/database/diary.db < /var/www/app/database/schema.sql
RUN sqlite3 /var/www/app/database/diary.db < /var/www/app/database/seed.sql

# Expose port
EXPOSE 8000

# Start PHP built-in server directly (no start.sh script)
CMD php -S 0.0.0.0:8000 -t /var/www/app/public
