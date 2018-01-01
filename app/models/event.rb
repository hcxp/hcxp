class Event < ApplicationRecord
  include PgSearch

  dragonfly_accessor :poster

  scope :upcoming, ->{ where('start_at > ?', Time.zone.now.end_of_day) }
  scope :past, ->{ where('start_at <= ?', Time.zone.now.end_of_day) }
  scope :upcoming_first, -> { order(start_at: :asc) }

  pg_search_scope :search, against: [:name, :city],
                           using: {
                             tsearch: { prefix: true}
                           }
end
