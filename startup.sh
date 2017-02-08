#!/bin/bash

bundle install

if [[ $1 == "--live" ]] ; then
  GOVUK_APP_DOMAIN=www.gov.uk \
  GOVUK_WEBSITE_ROOT=https://www.gov.uk \
  PLEK_SERVICE_CONTENT_STORE_URI=https://www.gov.uk/api \
  PLEK_SERVICE_STATIC_URI=assets.publishing.service.gov.uk \
  bundle exec rails s -p 3074
else
  bundle exec rails s -p 3074
fi

