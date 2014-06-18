require 'spec_helper'

describe ContactPresenter do
  let(:contact) { ContactPresenter.new(contact_data) }

  it 'should access detail elements directly' do
    expect(contact.query_response_time).to eq(false)
    expect(contact.title).to eq('Annual Tax on Enveloped Dwellings (ATED)')
    expect(contact.more_info_email_address).to eq('addresses that you can mail')
  end

  it "should convert collections to lists of OpenStructs" do
    expect(contact.phone_numbers.length).to eq(1)
    expect(contact.phone_numbers.first.number).to eq('0845 603 0135')
    expect(contact.quick_links.length).to eq(0)
  end

  it "should access Organisation as an OpenStruct" do
    expect(contact.organisation.abbreviation).to eq('HMRC')
    expect(contact.organisation.slug).to eq('hm-revenue-customs')
  end
end
