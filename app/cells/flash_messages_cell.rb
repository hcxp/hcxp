class FlashMessagesCell < Cell::ViewModel
  def show
    render
  end

  private

  def class_for_type(type)
    case type.to_sym
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-danger"
      when :notice
        "alert-info"
      else
        type.to_s
    end
  end

end
