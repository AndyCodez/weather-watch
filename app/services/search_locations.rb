class SearchLocations
  include HTTParty
  base_uri "https://api.openweathermap.org/data/2.5"

  def self.call(search_query)
    response = get("/find", query: {
                              q: search_query,
                              type: "like",
                              sort: "population",
                              appid: ENV["OPEN_WEATHER_MAP_API_KEY"],
                            })

    return [] unless response.success?

    locations = response["list"].map do |location|
      {
        name: location["name"],
        country_code: location["sys"]["country"],
      }
    end

    locations.uniq
  end
end
