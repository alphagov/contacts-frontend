Rails.application.routes.draw do

  with_options :format => false do |routes|
    routes.get "/government/organisations/:organisation/contact/:id" => "contacts#show"

    # FIXME: Remove this route once it's no longer being used by anything
    routes.get "/contact/:organisation/:id" => "contacts#show"

    routes.get "/healthcheck" => proc {|env| [200, {}, ["OK"]] }
  end
end
