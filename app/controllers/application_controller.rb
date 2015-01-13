class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template
  include Slimmer::SharedTemplates

  protect_from_forgery with: :exception

  private

  def error_404; error 404; end

  def error(status_code, exception = nil)
    if exception and defined? Airbrake
      env["airbrake.error_id"] = notify_airbrake(exception)
    end
    render status: status_code, text: "#{status_code} error"
  end

  def set_expiry(max_age = ContactsFrontend::Application.config.default_max_age)
    cache_control_directive = ContactsFrontend::Application.config.cache_control_directive
    return if cache_control_directive == 'no-cache'

    expires_in(max_age, public: cache_control_directive == 'public')
  end
end
