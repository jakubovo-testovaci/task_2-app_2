FROM php:apache-trixie

# Instalace systémových balíčků
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Povolení Apache mod_rewrite (často potřeba pro frameworky)
RUN a2enmod rewrite

# Instalace Composeru
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Nastavení pracovního adresáře
WORKDIR /var/www/

# Kopírování projektu (volitelné)
# COPY . /var/www/html

# Práva (pokud pojedeš třeba Laravel / Symfony)
RUN chown -R www-data:www-data /var/www/

EXPOSE 8000
