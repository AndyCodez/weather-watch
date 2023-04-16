class DashboardController < ApplicationController
  def weather
    @city = params[:city]
    @weather = GetCurrentWeatherData.call(city: @city)
    @forecast_data = GetForecastWeatherData.call(city: @city).drop(1) # Ignore first record
  end

  def search_cities
    search_query = params[:search_query]
    if search_query.present?
      @cities = SearchCities.search_cities(search_query)
      if @cities.count == 0
        flash.now[:warning] = "City not found"
        render "search_cities"
      end
    else
      @cities = []
    end
  end
end
