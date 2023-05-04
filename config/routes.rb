Rails.application.routes.draw do
  devise_for :users
  root "dashboard#search_locations"
  get "/search_locations", to: "dashboard#search_locations"
  get "/view_weather", to: "dashboard#view_weather", as: "view_weather"
  get "/locations/favorite_locations", to: "locations#favorite_locations", as: "favorite_locations"
  post "/locations/add_to_favorites", to: "locations#add_to_favorites", as: "add_to_favorites"
  delete "/locations/remove_from_favorites/:location_id", to: "locations#remove_from_favorites",
                                                          as: "remove_from_favorites"
end
