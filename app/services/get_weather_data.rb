require "httparty"

class GetWeatherData
  include HTTParty
  base_uri "https://api.openweathermap.org/data/2.5/forecast"

  def initialize(location_name:, country_code:)
    @location_name = location_name
    @country_code = country_code
  end

  def self.call(location_name:, country_code:)
    new(location_name: location_name, country_code: country_code).get_weather_data
  end

  def get_weather_data
    response = self.class.get("/?q=#{@location_name},#{@country_code}&appid=#{ENV["OPEN_WEATHER_MAP_API_KEY"]}")
    data = JSON.parse(response.body)["list"]
    {
      location: { name: @location_name, country_code: @country_code },
      current_weather: data.first["weather"][0],
      forecast_data: data.drop(1),
    }
  end
end
