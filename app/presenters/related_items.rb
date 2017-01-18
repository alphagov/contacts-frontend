class RelatedItems
  attr_reader :contact

  def initialize(contact)
    @contact = contact
  end

  def payload
    { sections: build_sections }
  end

private

  def build_sections
    sections = []

    if contact.quick_links.to_a.any?
      sections << {
        title: "Elsewhere on GOV.UK",
        items: contact.quick_links.map { |quick_link|
          { title: quick_link.title, url: quick_link.url }
        }
      }
    end

    if contact.related_links.any?
      sections << {
        title: "Other contacts",
        items: contact.related_links.map { |related_link|
          { title: related_link.fetch("title"), url: related_link.fetch("base_path") }
        }
      }
    end

    sections
  end
end
