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
    content_tag(:div, class: "nav nav-sidebar panel list-group") do
      yield
    end
  end

  def side_link(text, path)
    options = current_page?(path) ? { class: "active" } : {}
    content_tag(:li, options) do
        link_to text, path
    end
  end

  def side_child_link(text, path)
    options = current_page?(path) ? { class: "active-tab list-group-item active small" } : {class: "list-group-item small"}
    content_tag(:li, options) do
        link_to text, path
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    button_tag(name, class:"add_fields btn btn-info btn-sm", data: {id: id, fields: fields.gsub("\n", "")})
  end

end
