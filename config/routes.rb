Rails.application.routes.draw do
  root "dashboard#search_cities"
  get "/view_weather/:city", to: "dashboard#weather", as: "/view_weather"
end
