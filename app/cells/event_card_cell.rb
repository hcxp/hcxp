class EventCardCell < Cell::ViewModel
  def show
    render
  end

  private

  def model_decor
    model.decorate
  end

  def name_or_bands
    model.name.present? ? model.name : model.bands.map(&:name).join(', ')
  end

end
