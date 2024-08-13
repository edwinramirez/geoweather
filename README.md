# README

This is a Ruby on Rails application that uses the OpenWeatherMap API to display the 
current weather based on your browser geolocation. The application is built using Ruby 3.0.0 and 
Rails 7, a little bit of HTMX.

## Installation


1. run ```git clone git@github.com:edwinramirez/geoweather.git```
2. run ```cd geoweather``` and ```bundle install```
3. run ```cp .env_example .env``` to add your own OpenWeatherMap API key 
4. Create a free account at https://openweathermap.org/api, obtain your own API key and add 
   it to the .env file. Take note that you must subscribe to "One Call by Call" subscription 
   plan to be able to use "One Call API 3.0". This plan includes 1,000 API calls per day for 
   free so, for testing and development purposes, it should be enough. 
5. run ```rails db:create && rails db:migrate```
6. run ```bin/dev``` to start the server
7. visit http://localhost:3000
8. Allow the browser to access your location
9. Enjoy the weather!
