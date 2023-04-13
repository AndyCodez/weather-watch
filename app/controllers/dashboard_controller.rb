class DashboardController < ApplicationController
  def weather
    @weather = GetCurrentWeatherData.call(city: params[:city])
    @forecast_data = GetForecastWeatherData.call(city: params[:city])
  end

  def search_cities
    search_query = params[:search_query]
    @cities = SearchCities.search_cities(search_query)
  end
end
