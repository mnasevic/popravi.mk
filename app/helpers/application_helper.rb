module ApplicationHelper
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def keywords(page_keywords)
    content_for(:keywords) { page_keywords }
  end

  def description(page_description)
    content_for(:description) { page_description }
  end

  def body_id
    parts = controller.controller_path.split('/')
    parts << controller.action_name
    parts.join('_')
  end

  def strip_tags_with_space(string)
    string.to_s.gsub(/<\/?[^>]*>/, " ").strip
  end
end
