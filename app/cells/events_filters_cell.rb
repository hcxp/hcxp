class EventsFiltersCell < ApplicationCell
  include ActionView::Helpers::FormOptionsHelper

  def show
    render
  end

  private

  def scope_options
    [
      [t('.upcoming'), nil],
      [t('.past'), 'past'],
      [t('.all'), 'all']
    ]
  end

end
