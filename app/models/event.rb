class Event < ApplicationRecord
  include PgSearch

  STATES = %w(new ready).freeze

  dragonfly_accessor :poster

  validates :state, inclusion: { in: STATES }

  scope :upcoming, -> { where('start_at > ?', Time.zone.now.beginning_of_day) }
  scope :past, -> { where('start_at < ?', Time.zone.now.beginning_of_day) }
  scope :upcoming_first, -> { order(start_at: :asc) }

  pg_search_scope :search, against: [:name, :city, :place_name],
                           using: {
                             tsearch: { prefix: true}
                           }
end
