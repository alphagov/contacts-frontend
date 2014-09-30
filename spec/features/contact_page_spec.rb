require 'spec_helper'

feature "Showing a contact page" do

  it "renders a contact page" do
    path = '/government/organisations/hm-revenue-customs/contact/annual-tax-on-enveloped-dwellings-ated'

    content_store_has_item(path, read_content_store_fixture('hmrc_ated'), 15.minutes.to_i)

    visit(path)

    expect(page).to have_content("Annual Tax on Enveloped Dwellings")
    expect(page.response_headers["Cache-Control"]).to eq("max-age=900, public")
    expect_links("#global-breadcrumb", {
      "Home" => "/",
      "HM Revenue & Customs" => "/government/organisations/hm-revenue-customs",
      "Contact HMRC" => "/government/organisations/hm-revenue-customs/contact",
    })
    expect_links(".quick-links", {
      "Annual Tax on Enveloped Dwellings" => "http://www.hmrc.gov.uk/ated/index.htm"      
    })
  end

  it "should 404 for a non-existent item in the content-store" do
    path = '/government/organisations/hm-revenue-customs/contact/bear-tax'

    content_store_does_not_have_item(path)

    visit(path)
    expect(page.status_code).to eq(404)
  end

  def expect_links(selector, links)
    within selector do
      found_links = page.all("li a").map(&:text).map(&:strip)
      expect(found_links).to eq(links.keys)

      links.each do |link_text, href|
        expect(page).to have_link(link_text, :href => href)
      end
    end
  end
end
