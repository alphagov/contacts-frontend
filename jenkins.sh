#!/bin/bash -x
set -e

export RAILS_ENV=test

git clean -fdx
bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment


# Lint changes introduced in this branch, but not for master
if [[ ${GIT_BRANCH} != "origin/master" ]]; then
  bundle exec govuk-lint-ruby \
    --diff \
    --cached \
    --format html --out rubocop-${GIT_COMMIT}.html \
    --format clang \
    app spec lib
fi
# Clone govuk-content-schemas depedency for contract tests
rm -rf tmp/govuk-content-schemas
git clone --branch deployed-to-production git@github.com:alphagov/govuk-content-schemas.git tmp/govuk-content-schemas

GOVUK_CONTENT_SCHEMAS_PATH=tmp/govuk-content-schemas COVERAGE=on bundle exec rake
