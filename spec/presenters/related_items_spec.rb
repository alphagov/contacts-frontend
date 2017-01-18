require 'spec_helper'

describe RelatedItems do
  describe "#payload" do
    it "doesn't return sections if they're not there" do
      item = GovukSchemas::RandomExample.for_schema(frontend_schema: 'contact').merge_and_validate(
        "details" => {
          "title" => 'A title',
          "quick_links" => [],
        },
        "links" => {
          "related" => []
        }
      )

      contact = ContactPresenter.new(item)
      payload = RelatedItems.new(contact).payload

      expect(payload).to eql(sections: [])
    end

    it "returns quick links" do
      item = GovukSchemas::RandomExample.for_schema(frontend_schema: 'contact').merge_and_validate(
        "details" => {
          "title" => 'A title',
          "quick_links" => [
            { "title" => "Some", "url" => "/url" }
          ],
        },
        "links" => {
          "related" => []
        }
      )

      contact = ContactPresenter.new(item)
      payload = RelatedItems.new(contact).payload

      expect(payload).to eql(sections: [{ title: "Elsewhere on GOV.UK", items: [{ title: "Some", url: "/url" }] }])
    end

    it "returns other contacts" do
      item = GovukSchemas::RandomExample.for_schema(frontend_schema: 'contact').merge_and_validate(
        "details" => {
          "title" => 'A title',
          "quick_links" => [],
        },
        "links" => {
          "related" => [
            { "title" => "Some", "base_path" => "/url", "content_id" => "483ce939-0ea2-448e-bbbf-df4f5e93bd92", "locale" => "en" }
          ]
        }
      )

      contact = ContactPresenter.new(item)
      payload = RelatedItems.new(contact).payload

      expect(payload).to eql(sections: [{ title: "Other contacts", items: [{ title: "Some", url: "/url" }] }])
    end
  end
end
