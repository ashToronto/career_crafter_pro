module ApplicationHelper
  def nav_link(text, path)
    class_name = 'nav-link'
    class_name += ' active' if current_page?(path)

    link_to text, path, class: class_name
  end
end
