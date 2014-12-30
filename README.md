# Contacts Frontend

Display different contact items for an organisation on GOV.UK, fetched from
content store.

Contacts are published by [alphagov/hmrc-contacts](https://github.com/alphagov/hmrc-contacts).

## Live examples

A contact page:
- https://www.gov.uk/government/organisations/hm-revenue-customs/contact/alcohol-duties-national-registration-unit

Note that the index page is served by [hmrc-contacts](https://github.com/alphagov/hmrc-contacts):
- https://www.gov.uk/government/organisations/hm-revenue-customs/contact


### Dependencies

- [alphagov/content-store](https://github.com/alphagov/content-store) - used to
  fetch contacts
- [alphagov/static](https://github.com/alphagov/staticc) - applies the GOV.UK
  look and feel

### Running the application

`bundle exec rails s -p 3074`

### Running the test suite

`bundle exec rake`

## Licence

[MIT License](LICENCE)
