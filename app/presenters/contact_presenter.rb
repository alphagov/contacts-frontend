class ContactPresenter
  attr_reader :contact

  def initialize(contact, _places = nil)
    @contact = contact
  end

  PASS_THROUGH_KEYS = [
    :title, :details, :links, :web_url
  ]

  PASS_THROUGH_DETAILS_KEYS = [
    :description, :query_response_time,
    :more_info_contact_form, :more_info_email_address, :more_info_post_address, :more_info_phone_number
  ]

  PASS_THROUGH_COLLECTIONS_KEYS = [
    :quick_links, :phone_numbers, :email_addresses, :post_addresses,
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
      details[key.to_s].map {|item| OpenStruct.new(item)} if details
    end
  end

  def format
    @contact["format"]
  end

  def organisation
    # The only organisation in here is HMRC, so call `.first` on the array.
    links.fetch("organisations", []).map { |organisation| OpenStruct.new(organisation) }.first
  end

  def slug
    URI.parse(web_url).path.sub(%r{\A/}, "")
  end

  def related_links
    return [] unless contact["links"]
    contact["links"].fetch("related", []).map { |link| OpenStruct.new(link) }
  end

  def updated_at
    date = @contact["updated_at"]
    DateTime.parse(date) if date
  end
end
