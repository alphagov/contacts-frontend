require 'spec_helper'
require 'gds_api/test_helpers/content_store'

include GdsApi::TestHelpers::ContentStore

describe "Show contact page" do
  let(:path) { '/contact/hm-revenue-customs/annual-tax-on-enveloped-dwellings-ated' }
  before :each do
    content_store_has_item(path, contact_data)
  end

  it "displays contact details under relevant path" do
    visit(path)
    expect(page).to have_content(contact_data["title"])
    expect(page.response_headers["Cache-Control"]).to eq("max-age=1800, public")
  end
end
