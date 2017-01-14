module ApplicationHelper
  def parse_markdown(body)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    markdown.render(body)
  end
end
