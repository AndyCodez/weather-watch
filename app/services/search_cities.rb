class SearchCities
  include HTTParty
  base_uri "https://api.openweathermap.org/data/2.5"

  def self.search_cities(query)
    response = get("/find", query: {
                              q: query,
                              type: "like",
                              sort: "population",
                              appid: ENV["OPEN_WEATHER_MAP_API_KEY"],
                            })

    return [] unless response.success?

    cities = response["list"].map do |city|
      {
        name: city["name"],
        country: city["sys"]["country"],
      }
    end

    cities.uniq
  end
end
