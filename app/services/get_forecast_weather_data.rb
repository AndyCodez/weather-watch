require "httparty"

class GetForecastWeatherData
  include HTTParty
  base_uri "https://api.openweathermap.org/data/2.5/forecast"
  attr_reader :location

  def initialize(location:)
    @location = location
  end

  def self.call(location:)
    new(location: location).get_forecast_data
  end

  def get_forecast_data
    begin
      response = self.class.get("/?q=#{@location}&appid=#{ENV["OPEN_WEATHER_MAP_API_KEY"]}")
      return JSON.parse(response.body)["list"]
    rescue StandardError => e
      puts "Error fetching weather data: #{e}"
      raise e
    end
  end
end
