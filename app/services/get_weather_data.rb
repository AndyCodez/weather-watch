require "httparty"

class GetWeatherData
  include HTTParty
  base_uri "https://api.openweathermap.org/data/2.5/forecast"

  def initialize(location:)
    @location = location
  end

  def self.call(location:)
    new(location: location).get_weather_data
  end

  def get_weather_data
    begin
      response = self.class.get("/?q=#{@location[:name]},#{@location[:country_code]}&appid=#{ENV["OPEN_WEATHER_MAP_API_KEY"]}")
      return JSON.parse(response.body)["list"]
    rescue StandardError => e
      puts "Error fetching weather data: #{e}"
      raise e
    end
  end
end
