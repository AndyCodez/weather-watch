class DashboardController < ApplicationController
  def weather
    @weather = GetCurrentWeatherData.call(city: "Nairobi")
    @forecast_data = GetForecastWeatherData.call(city: "Nairobi")
  end
end
