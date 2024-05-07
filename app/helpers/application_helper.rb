module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type.to_sym
    when :success
      'alert-success'
    when :error, :alert
      'alert-danger'
    when :notice
      'alert-info'
    when :warning
      'alert-warning'
    else
      flash_type.to_s
    end
  end
end
