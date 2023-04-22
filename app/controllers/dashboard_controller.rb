class DashboardController < ApplicationController
  def view_weather
    @location = { name: params[:location], country_code: params[:country_code] }
    response = GetWeatherData.call(location: @location)
    @current_weather = response.first["weather"].first
    @forecast_data = response.drop(1) # Ignore first record which is the current weather

    respond_to do |format|
      format.html
      format.json { render json: { location: @location, current_weather: @current_weather, forecast_data: @forecast_data }, status: :ok }
    end
  end

  def search_locations
    @locations = params[:search_query].present? ? SearchLocations.call(params[:search_query]) : []

    if @locations.any?
      respond_to do |format|
        format.html
        format.json { render json: { locations: @locations } }
      end
    else
      flash.now[:warning] = "Location not found"
      respond_to do |format|
        format.html { render "search_locations" }
        format.json { render json: { error: "Location not found" }, status: :not_found }
      end
    end
  end
end
