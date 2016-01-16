module ApplicationHelper
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def side_bar
    content_tag(:ul, class: "nav nav-sidebar") do
      yield
    end
  end

  def side_link(text, path)
    options = current_page?(path) ? { class: "active" } : {}
    content_tag(:li, options) do
        link_to text, path
    end
  end

end
