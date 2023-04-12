class DashboardController < ApplicationController
   def weather
    @weather = OpenWeatherMapService.get_weather_by_city("Nairobi")
   end 
end