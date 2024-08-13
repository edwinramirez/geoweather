Rails.application.routes.draw do
  root "weather_locations#index"
  get 'weather_locations/load_weather_by_coordinates', to: 'weather_locations#load_weather_by_coordinates', as: :load_weather_by_coordinates
  post 'weather_locations/load_weather_by_city', to: 'weather_locations#load_weather_by_city', as: :load_weather_by_city
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
