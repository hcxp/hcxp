class EventCardCell < ApplicationCell
  def show
    render
  end

  private

  def model_decor
    model.decorate
  end

end
