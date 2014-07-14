class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  protect_from_forgery with: :exception

  private

  def error_404; error 404; end

  def error(status_code, exception = nil)
    if exception and defined? Airbrake
      env["airbrake.error_id"] = notify_airbrake(exception)
    end
    render status: status_code, text: "#{status_code} error"
  end

  def expires_at(expiration_time = ContactsFrontend::Application.config.default_ttl.from_now)
    response.headers['Cache-Control'] = ContactsFrontend::Application.config.cache_control_directive
    response.headers['Expires'] = expiration_time.respond_to?(:httpdate) ? expiration_time.httpdate : expiration_time
  end

end
