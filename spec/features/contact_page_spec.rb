require 'spec_helper'

feature "Showing a contact page" do

  it "renders a contact page" do
    path = '/government/organisations/hm-revenue-customs/contact/annual-tax-on-enveloped-dwellings-ated'

    content_store_has_item(path, read_content_store_fixture('hmrc_ated'))

    visit(path)

    expect(page).to have_content("Annual Tax on Enveloped Dwellings")
    expect(page.response_headers["Cache-Control"]).to eq("max-age=1800, public")
  end

  it "should 404 for a non-existent item in the content-store" do
    path = '/government/organisations/hm-revenue-customs/contact/bear-tax'

    content_store_does_not_have_item(path)

    visit(path)
    expect(page.status_code).to eq(404)
  end

  it "renders a contact page at the old URL" do
    path = '/contact/hm-revenue-customs/annual-tax-on-enveloped-dwellings-ated'

    content_store_has_item(path, read_content_store_fixture('hmrc_ated_legacy_url'))

    visit(path)

    expect(page).to have_content("Annual Tax on Enveloped Dwellings")
    expect(page.response_headers["Cache-Control"]).to eq("max-age=1800, public")
  end
end
