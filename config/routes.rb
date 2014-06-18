Rails.application.routes.draw do
  get "/#{APP_SLUG}/:organisation/:id" => "contacts#show"
  get "/healthcheck" => proc {|env| [200, {}, ["OK"]] }
end
