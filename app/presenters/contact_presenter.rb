class ContactPresenter
  attr_reader :contact

  def initialize(contact, _places = nil)
    @contact = contact
  end

  PASS_THROUGH_KEYS = [
    :title, :details, :links, :web_url
  ].freeze

  PASS_THROUGH_DETAILS_KEYS = [
    :description, :query_response_time,
    :more_info_contact_form, :more_info_email_address, :more_info_post_address, :more_info_phone_number
  ].freeze

  PASS_THROUGH_COLLECTIONS_KEYS = [
    :quick_links, :phone_numbers, :email_addresses, :post_addresses,
    :contact_form_links
  ].freeze

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
      details[key.to_s].map { |item| OpenStruct.new(item) } if details
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
    contact.to_hash.dig("links", "related").to_a
  end

  def updated_at
    date = @contact["updated_at"]
    DateTime.parse(date) if date
  end

  def show_webchat?
    # These are the routes on which we plan to roll out webchat, in stages.
    whitelisted_paths = [
      '/government/organisations/hm-revenue-customs/contact/child-benefit',
      '/government/organisations/hm-revenue-customs/contact/income-tax-enquiries-for-individuals-pensioners-and-employees',
      '/government/organisations/hm-revenue-customs/contact/vat-online-services-helpdesk',
      '/government/organisations/hm-revenue-customs/contact/national-insurance-numbers',
      '/government/organisations/hm-revenue-customs/contact/self-assessment-online-services-helpdesk',
      '/government/organisations/hm-revenue-customs/contact/self-assessment',
      '/government/organisations/hm-revenue-customs/contact/tax-credits-enquiries',
      '/government/organisations/hm-revenue-customs/contact/vat-enquiries',
      '/government/organisations/hm-revenue-customs/contact/customs-international-trade-and-excise-enquiries',
      '/government/organisations/hm-revenue-customs/contact/trusts',
      '/government/organisations/hm-revenue-customs/contact/employer-enquiries',
      '/government/organisations/hm-revenue-customs/contact/construction-industry-scheme',
    ]
    whitelisted_paths.include?(@contact["base_path"])
  end
end
