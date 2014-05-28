module LayoutHelper
  def render_stylesheets(tag_html = nil)
    html = []
    if tag_html.present?
      html << tag_html
    else
      html << stylesheet_link_tag('application', :media => 'all')
      html << stylesheet_link_tag(namespace, :media => 'all')
    end
    html.join("\n").html_safe
  end

  def render_javascripts(tag_html = nil)
    html = []
    if tag_html.present?
      html << tag_html
    else
      html << javascript_include_tag("application", "data-turbolinks-track" => true)
      html << javascript_include_tag(namespace, "data-turbolinks-track" => true)
    end
    html.join("\n").html_safe
  end

  def namespace
    controller_path.split('/').first
  end

end
