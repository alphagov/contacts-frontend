module ApplicationHelper
  def page_class(css_class)
    content_for(:page_class, css_class)
  end
end
