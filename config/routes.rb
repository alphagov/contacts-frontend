Rails.application.routes.draw do

  get "/healthcheck" => proc {|env| [200, {}, ["OK"]] }
end
