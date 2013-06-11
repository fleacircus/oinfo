module ApplicationHelper

def markdown(text)
  args = {
    :autolink => true,
    :no_intra_emphasis => true,
    :space_after_headers => true,
    :fenced_code_blocks => true
  }
  Redcarpet::Markdown.new(Redcarpet::Render::XHTML, args).render(text).html_safe
end

end
