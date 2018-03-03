class Band < ApplicationRecord
  dragonfly_accessor :photo

  has_many :band_events, dependent: :destroy
end
