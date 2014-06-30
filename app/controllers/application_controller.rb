class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  protect_from_forgery with: :exception

  private

  def set_expiry(duration = 30.minutes)
    unless Rails.env.development?
      expires_in(duration, :public => true)
    end
  end
end
