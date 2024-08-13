require 'rails_helper'

RSpec.describe WeatherLocation, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      weather_location = WeatherLocation.new(latitude: 40.7128, longitude: -74.0060)
      expect(weather_location).to be_valid
    end

    it 'is not valid without a latitude' do
      weather_location = WeatherLocation.new(latitude: nil, longitude: -74.0060)
      expect(weather_location).to_not be_valid
    end

    it 'is not valid without a longitude' do
      weather_location = WeatherLocation.new(latitude: 40.7128, longitude: nil)
      expect(weather_location).to_not be_valid
    end
  end

  describe 'scopes' do
    before do
      @weather_location = WeatherLocation.create(latitude: 40.7128, longitude: -74.0060, created_at: 30.minutes.ago)
    end

    it 'returns records within the cache period' do
      result = WeatherLocation.in_cache(40.7128, -74.0060)
      expect(result).to include(@weather_location)
    end

    it 'does not return records outside the cache period' do
      @weather_location.update(created_at: 2.hours.ago)
      result = WeatherLocation.in_cache(40.7128, -74.0060)
      expect(result).to be_empty
    end
  end
end