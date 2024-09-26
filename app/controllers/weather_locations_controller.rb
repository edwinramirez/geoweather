class WeatherLocationsController < ApplicationController

  def index; end

  def load_weather_by_coordinates
    if weather_data_in_cache(params[:latitude], params[:longitude])
      render partial: 'success', locals: {weather_data: @weather_data_in_cache}
      return
    end

    weather_data = WeatherService.fetch_weather_by_gps_coordinates(params[:latitude], params[:longitude])

    if weather_data && weather_location(weather_data)
      if @weather_location.save
        render partial: 'success', locals: {weather_data: @weather_location}
      else
        render partial: 'failure'
      end
    else
      render partial: 'failure'
    end
  end

  def load_weather_by_city
    city_data = WeatherService.fetch_gps_coordinates_by_city(params[:city_name])

    unless city_data
      render partial: 'failure'
      return
    end

    if weather_data_in_cache(city_data[0]["lat"].round(4), city_data[0]["lon"].round(4))
      render partial: 'success', locals: {weather_data: @weather_data_in_cache}
      return
    end

    weather_data = WeatherService.fetch_weather_by_gps_coordinates(city_data[0]["lat"].round(4), city_data[0]["lon"].round(4))
    if weather_data && weather_location(weather_data)
      if @weather_location.save
        render partial: 'success', locals: {weather_data: @weather_location}
      else
        render partial: 'failure'
      end
    else
      render partial: 'failure'
    end
  end

  private
  def weather_data_in_cache(latitude, longitude)
    @weather_data_in_cache = WeatherLocation.in_cache(latitude, longitude).first
  end

  def weather_location(weather_data)
    @weather_location = WeatherLocation.new(
      latitude: weather_data['lat'],
      longitude: weather_data['lon'],
      temperature: weather_data['current']['temp'],
      weather: weather_data['current']['weather'][0]['main'],
      icon: weather_data['current']['weather'][0]['icon'],
      full_response: weather_data
    )
  end
end
