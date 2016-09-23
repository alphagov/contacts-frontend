require 'gds_api/helpers'
require 'gds_api/content_store'

class ContactsController < ApplicationController
  include GdsApi::Helpers

  helper_method :organisation

  def show
    begin
      obj = content_store.content_item(request.path)

      set_expiry(obj.expires_in)
      @contact = ContactPresenter.new(obj)
    rescue GdsApi::HTTPNotFound
      error_404 && return
    rescue GdsApi::HTTPGone
      error_410 && return
    end
  end

private

  def organisation
    @contact.organisation
  end

  def content_store
    @content_store ||= GdsApi::ContentStore.new(Plek.current.find("content-store"))
  end
end
