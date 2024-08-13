# Service to fetch weather data from OpenWeather API
require 'net/http'

class WeatherService
  def self.fetch_weather(latitude, longitude)
    api_key = ENV['OPEN_WEATHER_MAP_API_KEY']
    url = "https://api.openweathermap.org/data/3.0/onecall?lat=#{latitude}&lon=#{longitude}&appid=#{api_key}&units=imperial"
    response = Net::HTTP.get(URI(url))
    JSON.parse(response) if response
  rescue StandardError
    nil
  end

  def self.fetch_weather_by_city(city_name)
    api_key = ENV['OPEN_WEATHER_MAP_API_KEY']
    url = "http://api.openweathermap.org/geo/1.0/direct?q=#{city_name}&limit=1&appid=#{api_key}"
    response = Net::HTTP.get(URI(url))
    JSON.parse(response) if response
  rescue StandardError
    nil
  end
end