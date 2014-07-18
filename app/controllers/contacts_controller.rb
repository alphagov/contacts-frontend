require 'gds_api/helpers'
require 'gds_api/content_store'

class ContactsController < ApplicationController
  include GdsApi::Helpers

  before_filter :set_beta_notice, only: :show
  helper_method :organisation

  def show
    obj = content_store.content_item(request.path)
    error_404 and return unless obj

    set_expiry(obj.expires_in)
    @contact = ContactPresenter.new(obj)
  end

  private

  def organisation
    @contact.organisation
  end

  def set_beta_notice
    response.header[Slimmer::Headers::BETA_LABEL] = "after:.header-block"
  end

  def content_store
    @content_store ||= GdsApi::ContentStore.new(Plek.current.find("content-store"))
  end
end
