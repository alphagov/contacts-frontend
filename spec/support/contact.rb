module ContactHelper
  def contact_data()
    contact = {
      "base_path" => "/contact/hm-revenue-customs/annual-tax-on-enveloped-dwellings-ated",
     "description" => "For information and advice about ATED, who needs to complete and submit a return and make a payment",
     "details" =>
      {"contact_form_links" =>
        [{"link" => "http://www.hmrc.gov.uk/ated/index.htm",
          "title" => "Annual Tax on Enveloped Dwellings (ATED) - the basics"}],
       "contact_groups" =>
        [{"contacts" =>53,
          "description" =>
           "General Tax enquiries for individuals, employees and self-employed",
          "organisation" =>
           {"abbreviation" => "HMRC",
            "format" => "Non-ministerial department",
            "govuk_status" => "live",
            "id" =>24,
            "slug" => "hm-revenue-customs",
            "title" => "HM Revenue & Customs"},
          "title" => "Tax"}],
       "description" =>
        "For information and advice about ATED, who needs to complete and submit a return and make a payment",
       "email_addresses" => [],
       "language" => "en",
       "more_info_contact_form" => "",
       "more_info_email_address" => "addresses that you can mail",
       "more_info_post_address" => "Postie data and stuff",
       "organisation" =>
        {"abbreviation" => "HMRC",
         "format" => "Non-ministerial department",
         "govuk_status" => "live",
         "id" =>24,
         "slug" => "hm-revenue-customs",
         "title" => "HM Revenue & Customs"},
       "phone_numbers" =>
        [{"best_time_to_call" => nil,
          "description" => "For <i>enquiries</i> relating to ATED",
          "fax" => "03000 570 316",
          "international_phone" => "+44 1726 209 042",
          "number" => "0845 603 0135",
          "open_hours" =>
           "8.30 am to 5.00 pm Monday to Friday\r\nClosed weekends and bank holidays",
          "textphone" =>nil,
          "title" => "Annual Tax on Enveloped Dwellings Helpline"}],
       "post_addresses" => [],
       "query_response_time" =>false,
       "quick_links" => [],
       "slug" => "annual-tax-on-enveloped-dwellings-ated",
       "title" => "Annual Tax on Enveloped Dwellings (ATED)"},
     "format" => "contact",
     "need_ids" => [],
     "public_updated_at" => "2014-06-16T14:55:18.000Z",
     "publishing_app" => "contacts",
     "rendering_app" => "contacts-frontend",
     "routes" =>
      [{"path" => "/contact/hm-revenue-customs/annual-tax-on-enveloped-dwellings-ated",
        "rendering_app" => "contacts-frontend",
        "type" => "exact"}],
     "title" => "Annual Tax on Enveloped Dwellings (ATED)",
     "update_type" => "major"}
  end
end

RSpec.configuration.include ContactHelper
