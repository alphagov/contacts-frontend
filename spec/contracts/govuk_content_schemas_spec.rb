require "spec_helper"
require "gds_api/test_helpers/content_store"

RSpec.describe "Schema compatibility", type: :request do
  include GdsApi::TestHelpers::ContentStore

  all_examples_for_supported_formats = GovukContentSchemaTestHelpers::Examples.new.get_all_for_formats(%w{
    contact
  })

  all_examples_for_supported_formats.each do |example|
    content_item = JSON.parse(example)

    it "can handle a request for #{content_item['base_path']}" do
      stub_shared_component_locales
      content_store_has_item(content_item['base_path'], content_item)

      get content_item['base_path']
      expect(response.status).to eq(200)
      assert_select 'title', Regexp.new(Regexp.escape(content_item['title']))
    end
  end
end
