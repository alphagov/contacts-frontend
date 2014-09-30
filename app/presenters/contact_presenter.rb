class ContactPresenter

  attr_reader :contact

  def initialize(contact, places = nil)
    @contact = contact
  end

  PASS_THROUGH_KEYS = [
    :title, :details, :web_url
  ]

  PASS_THROUGH_DETAILS_KEYS = [
    :description, :organisation, :query_response_time, :links,
    :more_info_contact_form, :more_info_email_address, :more_info_post_address, :more_info_phone_number
  ]

  PASS_THROUGH_COLLECTIONS_KEYS = [
    :phone_numbers, :email_addresses, :post_addresses,
    :contact_form_links
  ]

  PASS_THROUGH_KEYS.each do |key|
    define_method key do
      contact[key.to_s]
    end
  end

  PASS_THROUGH_DETAILS_KEYS.each do |key|
    define_method key do
      details[key.to_s] if details
    end
  end

  PASS_THROUGH_COLLECTIONS_KEYS.each do |key|
    define_method key do
      if details
        details[key.to_s].map {|item| OpenStruct.new(item)}
      end
    end
  end

  def format
    @contact["format"]
  end

  def organisation
    OpenStruct.new(details['organisation'])
  end

  def slug
    URI.parse(web_url).path.sub(%r{\A/}, "")
  end
  
  def links
    unless details and details.has_key?("links")
      return OpenStruct.new(related:[])
    end

    OpenStruct.new(
      Hash[
        details["links"].map do |k,v| 
          [k, v.map { |i| OpenStruct.new(i) }]
        end
      ]
    )
  end

  def updated_at
    date = @contact["updated_at"]
    DateTime.parse(date) if date
  end

end

