#!/bin/sh

# print all commands that are executed. fail on any error
set -e -x

apt-get update

apt-get install -y git unzip

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --filename=composer --install-dir=/usr/bin
php -r "unlink('composer-setup.php');"

composer install --no-progress --no-suggest

#curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

cd prepaid-card


# run tests
set +e

php bin/phpunit tests

TEST_EXIT_CODE=$?
echo $TEST_EXIT_CODE

exit $TEST_EXIT_CODE