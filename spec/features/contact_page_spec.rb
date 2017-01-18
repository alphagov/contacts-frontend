require 'spec_helper'

feature "Showing a contact page" do
  before do
    stub_shared_component_locales
  end

  it "renders a contact page" do
    path = '/government/organisations/hm-revenue-customs/contact/annual-tax-on-enveloped-dwellings-ated'

    # The expires_in method dynamically generates a value by subtracting
    # a default number from Time.now. In practice this means that we're not
    # guaranteed to get 900, it could 899 if the request takes longer than a
    # second to process.
    # See https://github.com/alphagov/gds-api-adapters/blob/45fdbf98398f1fab97ac26164db1621d3390aec5/lib/gds_api/response.rb#L57-L67
    allow_any_instance_of(GdsApi::Response).to receive(:expires_in).and_return(900)

    content_store_has_item(path, read_content_store_fixture('hmrc_ated'))

    visit(path)

    expect(page).to have_title 'Annual Tax on Enveloped Dwellings - Contact HM Revenue & Customs - GOV.UK'
    expect(page).to have_selector("meta[name='description'][content='Help about ATED (previously called Annual Residential Property Tax), who needs to submit a return and how to make a payment']", visible: false)
    expect(page).to have_content("Annual Tax on Enveloped Dwellings")
    expect(page.response_headers["Cache-Control"]).to eq("max-age=900, public")

    expect(page).to have_css(shared_component_selector('breadcrumbs'))

    within(shared_component_selector('breadcrumbs')) do
      expect(page).to have_content('Home')
      expect(page).to have_content('HM Revenue & Customs')
      expect(page).to have_content('Contact HM Revenue & Customs')
    end

    expect(page).to have_css(shared_component_selector('related_items'))

    within(shared_component_selector('related_items')) do
      expect(page).to have_content("Annual Tax on Enveloped Dwellings")
      expect(page).to have_content("Annual tax on enveloped dwellings contact")
    end
  end

  it "should 404 for a non-existent item in the content-store" do
    path = '/government/organisations/hm-revenue-customs/contact/bear-tax'

    content_store_does_not_have_item(path)

    visit(path)
    expect(page.status_code).to eq(404)
  end

  it "should 410 for a gone item in the content-store" do
    path = '/government/organisations/hm-revenue-customs/contact/medieval-tax'

    content_store_has_gone_item(path)

    visit(path)
    expect(page.status_code).to eq(410)
  end

  it "should render web chat" do
    path = "/government/organisations/hm-revenue-customs/contact/child-benefit"

    content_store_has_item(path, read_content_store_fixture("hmrc_child_benefit"))

    visit(path)

    expect(page).to have_title "Child Benefit: general enquiries"
    expect(page).to have_content "Webchat"
  end
end
