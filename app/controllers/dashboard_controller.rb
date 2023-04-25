class DashboardController < ApplicationController
  def view_weather
    @weather_data = GetWeatherData.call(location_name: params[:location], country_code: params[:country_code])

    respond_to do |format|
      format.html
      format.json do
        render json: { weather_data: @weather_data }, status: :ok
      end
    end
  rescue StandardError => e
    puts "Error: #{e}"
    flash[:warning] = 'Unable to fetch weather data'

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json do
        render json: { error: 'Unable to fetch weather data' }, status: :internal_server_error
      end
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
      respond_to do |format|
        format.html do
          flash.now[:warning] = 'Location not found' if params[:search_query].present?
          render 'search_locations'
        end
        format.json { render json: { error: 'Location not found' }, status: :not_found }
      end
    end
  end
end
