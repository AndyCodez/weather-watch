class DashboardController < ApplicationController
  def weather
    @location = params[:location]
    response = GetWeatherData.call(location: @location)
    @weather = response.first["weather"]
    @forecast_data = response.drop(1) # Ignore first record which is the current weather
  end

  def search_locations
    search_query = params[:search_query]
    if search_query.present?
      @locations = SearchLocations.search_locations(search_query)
      if @locations.count == 0
        flash.now[:warning] = "Location not found"
        render "search_locations"
      end
    else
      @locations = []
    end
  end
end
