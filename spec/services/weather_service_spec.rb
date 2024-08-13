require 'rails_helper'
require 'dotenv'

RSpec.describe WeatherService, type: :service do
  describe '.fetch_weather' do
    let(:latitude) { 40.7128 }
    let(:longitude) { -74.0060 }
    let(:api_key) { 'test_api_key' }
    let(:url) { "https://api.openweathermap.org/data/3.0/onecall?lat=#{latitude}&lon=#{longitude}&appid=#{api_key}&units=imperial" }
    let(:response_body) { { 'weather' => 'sunny' }.to_json }

    before do
      Dotenv.load('.env.test.local')
      stub_request(:get, url).to_return(body: response_body, status: 200)
    end

    it 'returns parsed JSON data for valid coordinates' do
      result = WeatherService.fetch_weather(latitude, longitude)
      expect(result).to eq(JSON.parse(response_body))
    end

    it 'returns nil on error' do
      stub_request(:get, url).to_return(status: 500)
      result = WeatherService.fetch_weather(latitude, longitude)
      expect(result).to be_nil
    end
  end

  describe '.fetch_weather_by_city' do
    let(:city_name) { 'New York' }
    let(:api_key) { 'test_api_key' }
    let(:url) { "http://api.openweathermap.org/geo/1.0/direct?q=#{city_name}&limit=1&appid=#{api_key}" }
    let(:response_body) { [{ 'name' => 'New York' }].to_json }

    before do
      Dotenv.load('.env.test.local')
      stub_request(:get, url).to_return(body: response_body, status: 200)
    end

    it 'returns parsed JSON data for a valid city name' do
      result = WeatherService.fetch_weather_by_city(city_name)
      expect(result).to eq(JSON.parse(response_body))
    end

    it 'returns nil on error' do
      stub_request(:get, url).to_return(status: 500)
      result = WeatherService.fetch_weather_by_city(city_name)
      expect(result).to be_nil
    end
  end
end