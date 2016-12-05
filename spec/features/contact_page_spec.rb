require 'spec_helper'

feature "Showing a contact page" do
  it "renders a contact page" do
    path = '/government/organisations/hm-revenue-customs/contact/annual-tax-on-enveloped-dwellings-ated'

    content_store_has_item(path, read_content_store_fixture('hmrc_ated'))

    visit(path)

    expect(page).to have_title 'Annual Tax on Enveloped Dwellings - Contact HM Revenue & Customs - GOV.UK'
    expect(page).to have_selector("meta[name='description'][content='Help about ATED (previously called Annual Residential Property Tax), who needs to submit a return and how to make a payment']", visible: false)
    expect(page).to have_content("Annual Tax on Enveloped Dwellings")

    # This assertion fails sometimes because the value it receives is `899` instead of `900`.
    # It doesn't happen on every build, here's an example failure:
    # https://ci.dev.publishing.service.gov.uk/job/govuk_contacts-frontend_branches/173/console
    expect(page.response_headers["Cache-Control"]).to eq("max-age=900, public")

    expect_links("#global-breadcrumb", "Home" => "/",
      "HM Revenue & Customs" => "/government/organisations/hm-revenue-customs",
      "Contact HM Revenue & Customs" => "/government/organisations/hm-revenue-customs/contact")
    expect_links(".quick-links", "Annual Tax on Enveloped Dwellings" => "http://www.hmrc.gov.uk/ated/index.htm")
    expect_links(".related-links", "Annual tax on enveloped dwellings contact" => "http://www.hmrc.gov.uk/ated/contact.htm",
      "Another contact" => "http://www.hmrc.gov.uk/ated/another.htm")
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

  def expect_links(selector, links)
    within selector do
      found_links = page.all("li a").map(&:text).map(&:strip)
      expect(found_links).to eq(links.keys)

      links.each do |link_text, href|
        expect(page).to have_link(link_text, href: href)
      end
    end
  end
end
