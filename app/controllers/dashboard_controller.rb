class DashboardController < ApplicationController
  def weather
    @city = params[:city]
    @weather = GetCurrentWeatherData.call(city: @city)
    @forecast_data = GetForecastWeatherData.call(city: @city)
  end

  def search_cities
    search_query = params[:search_query]
    @cities = SearchCities.search_cities(search_query)
  end
end
