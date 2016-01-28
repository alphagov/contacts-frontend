require 'gds_api/test_helpers/content_store'

module ContentStoreHelpers
  def read_content_store_fixture(basename)
    File.read(Rails.root.join("spec", "fixtures", "content_store", "#{basename}.json"))
  end
end

RSpec.configuration.include GdsApi::TestHelpers::ContentStore, type: :feature
RSpec.configuration.include ContentStoreHelpers
