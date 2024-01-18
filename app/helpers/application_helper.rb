module ApplicationHelper
  def active_link_to(name, path, options = {})
    class_name = options[:class]
    active_class = options[:active] || "active-link"

    if current_page?(path)
      class_name = [class_name, active_class].compact.join(" ")
    end

    link_to name, path, options.merge(class: class_name)
  end
end
