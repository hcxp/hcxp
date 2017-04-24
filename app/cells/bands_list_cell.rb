class BandsListCell < Cell::ViewModel
  def buttons
    render
  end

  private

  def size_class
    size = options[:size] || 'md'
    "btn-#{size}"
  end

end
