require 'httparty'

class OpenWeatherMapService
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5/weather'

  def self.get_weather_by_city(city)
    new.get_weather_data(city)
  end

  def get_weather_data(city)
    begin
      response = self.class.get("/?q=#{city}&appid=#{ENV["OPEN_WEATHER_MAP_API_KEY"]}")
      return JSON.parse(response.body)["weather"]
    rescue StandardError => e
      puts "Error fetching weather data: #{e}"
      raise e
    end
  end
end
