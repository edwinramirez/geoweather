class WeatherLocation < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true

  scope :in_cache, ->(latitude, longitude) {
    where('latitude=? AND longitude=? AND created_at > ?', latitude, longitude, 1.hour.ago.utc).limit(1)
  }

  def self.success_html_string(weather_data)
    "<p>Weather Data for (#{weather_data&.latitude}, #{weather_data&.longitude})</p>
      <p>Temperature: #{weather_data&.temperature}</p>
      <p>Weather: #{weather_data&.weather}</p>
      <p><img src='http://openweathermap.org/img/wn/#{weather_data&.icon}@2x.png'></p>"
  end

  def self.failure_html_string
    "<p>Content not loaded</p>"
  end
end
