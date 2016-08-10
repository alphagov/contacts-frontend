Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  with_options :format => false do |routes|
    routes.get "/government/organisations/:organisation/contact/:id" => "contacts#show"

    routes.get "/healthcheck" => proc {|env| [200, {}, ["OK"]] }
  end
end
