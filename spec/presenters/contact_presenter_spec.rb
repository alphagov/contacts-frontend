require 'spec_helper'

describe ContactPresenter do
  let(:contact) { ContactPresenter.new(JSON.parse(read_content_store_fixture("hmrc_ated"))) }

  it 'should access detail elements directly' do
    expect(contact.query_response_time).to eq(false)
    expect(contact.title).to eq('Annual Tax on Enveloped Dwellings')
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
