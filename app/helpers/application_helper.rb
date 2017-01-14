module ApplicationHelper
  def parse_markdown(body)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(with_toc_data: true, hard_wrap: true),
      extensions = {}
    )
    markdown.render(body)
  end
end
