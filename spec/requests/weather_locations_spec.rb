# spec/controllers/weather_locations_controller_spec.rb
require 'rails_helper'

RSpec.describe WeatherLocationsController, type: :controller do
  describe 'GET #load_weather_by_coordinates' do
    let(:latitude) { 40.7128 }
    let(:longitude) { -74.0060 }
    let(:weather_data) { { 'lat' => latitude, 'lon' => longitude, 'current' => { 'temp' => 75, 'weather' => [{ 'main' => 'Clear', 'icon' => '01d' }] } } }

    before do
      allow(WeatherService).to receive(:fetch_weather_by_gps_coordinates).and_return(weather_data)
    end

    context 'when weather data is in cache' do
      let!(:weather_location) { WeatherLocation.create(latitude: latitude, longitude: longitude, created_at: 30.minutes.ago) }

      it 'renders the cached weather data' do
        get :load_weather_by_coordinates, params: { latitude: latitude, longitude: longitude }
        expect(response).to render_template(partial: '_success')
      end
    end

    context 'when weather data is not in cache' do
      let!(:weather_location) { WeatherLocation.create(latitude: latitude, longitude: longitude, created_at: 2.hours.ago) }

      it 'fetches new weather data and saves it' do
        expect {
          get :load_weather_by_coordinates, params: { latitude: latitude, longitude: longitude }
        }.to change(WeatherLocation, :count).by(1)
        expect(response).to render_template(partial: '_success')
      end

      it 'renders failure message if data cannot be saved' do
        allow_any_instance_of(WeatherLocation).to receive(:save).and_return(false)
        get :load_weather_by_coordinates, params: { latitude: latitude, longitude: longitude }
        expect(response).to render_template(partial: '_failure')
      end
    end
  end

  describe 'GET #load_weather_by_city' do
    let(:city_name) { 'New York' }
    let(:latitude) { 40.7128 }
    let(:longitude) { -74.0060 }
    let(:city_data) { [{ 'lat' => latitude, 'lon' => longitude }] }
    let(:weather_data) { { 'lat' => latitude, 'lon' => longitude, 'current' => { 'temp' => 75, 'weather' => [{ 'main' => 'Clear', 'icon' => '01d' }] } } }

    before do
      allow(WeatherService).to receive(:fetch_gps_coordinates_by_city).and_return(city_data)
      allow(WeatherService).to receive(:fetch_weather_by_gps_coordinates).and_return(weather_data)
    end

    context 'when weather data is in cache' do
      let!(:weather_location) { WeatherLocation.create(latitude: latitude, longitude: longitude, created_at: 30.minutes.ago) }

      it 'renders the cached weather data' do
        get :load_weather_by_city, params: { city_name: city_name }
        expect(response).to render_template(partial: '_success')
      end
    end

    context 'when weather data is not in cache' do
      let!(:weather_location) { WeatherLocation.create(latitude: latitude, longitude: longitude, created_at: 2.hours.ago) }

      it 'fetches new weather data and saves it' do
        expect {
          get :load_weather_by_city, params: { city_name: city_name }
        }.to change(WeatherLocation, :count).by(1)
        expect(response).to render_template(partial: '_success')
      end

      it 'renders failure message if data cannot be saved' do
        allow_any_instance_of(WeatherLocation).to receive(:save).and_return(false)
        get :load_weather_by_city, params: { city_name: city_name }
        expect(response).to render_template(partial: '_failure')
      end
    end

    context 'when city data cannot be fetched' do
      before do
        allow(WeatherService).to receive(:fetch_gps_coordinates_by_city).and_return(nil)
      end

      it 'renders failure message' do
        get :load_weather_by_city, params: { city_name: city_name }
        expect(response).to render_template(partial: '_failure')
      end
    end
  end
end