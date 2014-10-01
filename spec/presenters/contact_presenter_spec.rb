require 'spec_helper'

describe ContactPresenter do
  let(:contact) { ContactPresenter.new(JSON.parse(read_content_store_fixture("hmrc_ated"))) }

  it 'should access detail elements directly' do
    expect(contact.query_response_time).to eq(false)
    expect(contact.title).to eq('Annual Tax on Enveloped Dwellings')
  end

  it "should access links elements directly" do
    expect(contact.links.related.first.title).to eq("Annual Tax on Enveloped Dwellings ")
    expect(contact.links.related.first.api_url).to eq("http://www.hmrc.gov.uk/api/ated.json")
    expect(contact.links.related.first.web_url).to eq("http://www.hmrc.gov.uk/ated/index.htm")
  end

  it "should handle the absence of links gracefully" do
    content_store_data = JSON.parse(read_content_store_fixture("hmrc_ated"))
    content_store_data.delete("details")
    presenter = ContactPresenter.new(content_store_data)
    expect(presenter.links.related).to be_empty
  end

  it "should convert collections to lists of OpenStructs" do
    expect(contact.phone_numbers.length).to eq(1)
    expect(contact.phone_numbers.first.number).to eq('0300 200 3510')
    expect(contact.email_addresses.length).to eq(0)
  end

  it "should access Organisation as an OpenStruct" do
    expect(contact.organisation.abbreviation).to eq('HMRC')
    expect(contact.organisation.slug).to eq('hm-revenue-customs')
  end
end
