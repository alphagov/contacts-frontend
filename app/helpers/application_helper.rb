module ApplicationHelper

  # This hackery is necessary while we're supporting both the new and the legacy routes.
  # We want the legacy contact page to link to the legacy index URL, while the new contact
  # page should link to the new index URL
  # FIXME: Remove this when we no longer need to support both URL schemes
  def calculate_contacts_index_path(org)
    if request.path.start_with?("/contact/")
      "/contact/#{org.slug}"
    else
      "/government/organisations/#{org.slug}/contact"
    end
  end
end
