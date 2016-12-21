class EventMetaListCell < ApplicationCell
  include ActionView::Helpers::DateHelper

  def show
    render
  end

  private

  def user_decor
    model.user.decorate
  end

  def humanized_date
    time = time_ago_in_words(model.beginning_at)

    if model.beginning_at.today?
      text = ['Today']
    elsif model.beginning_at.to_date == Date.tomorrow
      text = ['Tomorrow']
    elsif model.beginning_at.to_date == Date.yesterday
      text = ['Yesterday']
    elsif model.beginning_at > Time.zone.now
      text = ['In', time]
    else
      text = [time, 'ago']
    end

    text.join(' ')
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
