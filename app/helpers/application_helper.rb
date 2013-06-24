module ApplicationHelper

  def markdown(text)
    render_args = {
      :hard_wrap => true,
      :filter_html => true
    }
    markdown_args = {
      :autolink => true,
      :no_intra_emphasis => true,
      :space_after_headers => true,
      :fenced_code_blocks => true
    }
    Redcarpet::Markdown.new(
      Redcarpet::Render::XHTML.new(render_args), markdown_args
    ).render(text).html_safe
  end


  def link_to_file(file)
    type = file.content_type.nil? ? '' : file.content_type.gsub(/\/|\.|-/, ' ')
    size = file.file_size.nil? ? '' : content_tag(:span, "[#{number_with_precision(file.file_size / 1000.0)} kB]", :class => 'small')
    if File.exist? file.intern_url
      link = link_to(file.name, file.public_url, :class => "icon file #{type}", :target => '_blank')
    else
      link = content_tag(:del, file.name, :class => "icon file #{type}")
    end
    (link + size).html_safe
  end


  def unknown_value
    content_tag('span', t('app.label.unknown'), :class => 'nil')
  end

  def not_specified_value
    content_tag('span', t('app.label.not_specified'), :class => 'nil')
  end

end
