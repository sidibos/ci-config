#!/bin/sh

# print all commands that are executed. fail on any error
set -e -x

apt-get update

apt-get install -y git unzip

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

cd prepaid-card

composer install --no-progress --no-suggest

# run tests
set +e

php ./bin/phpunit tests

TEST_EXIT_CODE=$?
echo $TEST_EXIT_CODE

exit $TEST_EXIT_CODE