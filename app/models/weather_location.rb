class WeatherLocation < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true

  scope :in_cache, ->(latitude, longitude) {
    where('latitude=? AND longitude=? AND created_at > ?', latitude, longitude, 1.hour.ago.utc).limit(1)
  }
end
