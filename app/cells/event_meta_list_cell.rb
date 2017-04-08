class EventMetaListCell < ApplicationCell
  include ActionView::Helpers::DateHelper

  def show
    render
  end

  private

  def user_decor
    model.user.decorate
  end

  def model_decor
    model.decorate
  end

  def humanized_date_class
    if model.beginning_at.today?
      'text-danger'
    elsif model.beginning_at.to_date == Date.tomorrow
      'text-warning'
    elsif model.beginning_at < Time.zone.now + 5.days && model.beginning_at.future?
      'text-success'
    end
  end

end
