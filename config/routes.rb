Rails.application.routes.draw do
  devise_for :users
  root "dashboard#search_cities"
  get "/view_weather/:city", to: "dashboard#weather", as: "/view_weather"
  get "/cities/favorite_cities", to: "cities#favorite_cities", as: "/favorite_cities"
  post "/cities/add_to_favorites", to: "cities#add_to_favorites", as: "/add_to_favorites"
  delete "/cities/remove_from_favorites/:city_id", to: "cities#remove_from_favorites", as: "/remove_from_favorites"
end
