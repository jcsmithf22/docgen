module ApplicationHelper
  def active_link_to(name = nil, options = nil, html_options = nil, &block)
    path = options
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_target(name, options)
    html_options["href"] ||= url
    class_name = html_options["class"]
    active_class = html_options["active"]
    default_class = html_options["default"]

    if current_page?(url)
      class_name = [class_name, active_class].compact.join(" ")
      html_options["class"] = class_name
    else
      class_name = [class_name, default_class].compact.join(" ")
      html_options["class"] = class_name
    end

    html_options.delete("active")
    html_options.delete("inactive")

    content_tag("a", name || url, html_options, &block)
  end

  def full_title(page_title = '')
    base_title = "Reportify"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def current_page_any?(paths)
    paths.any? { |path| current_page?(path) }
  end
end
