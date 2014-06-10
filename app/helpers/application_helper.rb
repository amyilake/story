module ApplicationHelper

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    target.active_model_serializer.new(target, options).as_json
  end

  def safe(content)
    "#{content}".html_safe
  end

end
