# Gunakan base image PHP dengan Node.js
FROM php:8.2.27-fpm

# Instal dependensi yang diperlukan untuk Laravel dan Node.js
RUN apt-get update && apt-get install -y \
  zip unzip git curl libpng-dev libonig-dev libxml2-dev nodejs npm \
  && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instal Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Salin file composer.json dan package.json untuk instalasi dependensi
COPY composer.json composer.lock ./
COPY package.json package-lock.json ./

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 775 /var/www/html

# Instal Composer dependencies
RUN composer install --no-dev --optimize-autoloader --prefer-dist --no-scripts --no-progress

# Salin seluruh file proyek ke dalam container
COPY . .

# Instal Node.js dependencies
RUN npm install && npm run build

# Set izin folder storage dan cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
  && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Membuat File Env di docker container
RUN cp .env.example .env

# Generate key Laravel
# RUN php artisan key:generate

# Expose port 9000 untuk PHP-FPM
EXPOSE 9000

CMD ["php-fpm"]
