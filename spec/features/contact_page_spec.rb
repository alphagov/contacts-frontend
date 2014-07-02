require 'spec_helper'

feature "Showing a contact page" do
  it "renders a contact page" do
    path = '/contact/hm-revenue-customs/annual-tax-on-enveloped-dwellings-ated'

    content_store_has_item(path, read_content_store_fixture('hmrc_ated'))

    visit(path)

    expect(page).to have_content("Annual Tax on Enveloped Dwellings")
    expect(page.response_headers["Cache-Control"]).to eq("max-age=1800, public")
  end
end
