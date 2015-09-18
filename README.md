# Contacts Frontend

Display different contact items for an organisation on GOV.UK, fetched from
content store.

Contacts are published by [alphagov/contacts-admin](https://github.com/alphagov/contacts-admin).

## Live examples

A contact page:
- https://www.gov.uk/government/organisations/hm-revenue-customs/contact/alcohol-duties-national-registration-unit

Note that the index page is served by [contacts-admin](https://github.com/alphagov/contacts-admin):
- https://www.gov.uk/government/organisations/hm-revenue-customs/contact


### Dependencies

- [alphagov/content-store](https://github.com/alphagov/content-store) - used to
  fetch contacts
- [alphagov/static](https://github.com/alphagov/staticc) - applies the GOV.UK
  look and feel

### Running the application

`bundle exec rails s -p 3074`

Running using bowler in the VM from cd /var/govuk/development/:

```
bowl contacts-frontend
```

If you are using the GDS development virtual machine then the application will be available on the host at http://contacts-frontend.dev.gov.uk/government/organisations/hm-revenue-customs/contact/air-passenger-duty.
Note: To view the above page, you will need to have replicated data from preview.

### Running the test suite

`bundle exec rake`

## Licence

[MIT License](LICENCE)
