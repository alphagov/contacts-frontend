require 'gds_api/test_helpers/content_store'

module ContentStoreHelpers
  def read_content_store_fixture(basename)
    json = File.read(Rails.root.join("spec", "fixtures", "content_store", "#{basename}.json"))
    content_item = JSON.parse(json)
    GovukSchemas::RandomExample.for_schema(frontend_schema: 'contact').merge_and_validate(content_item)
  end
end

RSpec.configuration.include GdsApi::TestHelpers::ContentStore, type: :feature
RSpec.configuration.include ContentStoreHelpers
