class CitiesController < ApplicationController
  def add_to_favorites
    city = current_user.cities.build(name: params[:city_name])
    if city.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Added to favorites successfully."
          redirect_to favorite_cities_path
        }
      end
    else
      respond_to do |format|
        format.html {
          redirect_to favorite_cities_path
        }
      end
    end
  end

  def favorite_cities
    @cities = current_user.cities
  end

  def remove_from_favorites
    city = City.find(params[:city_id])
    city.destroy!
    respond_to do |format|
      format.html { redirect_to favorite_cities_path }
    end
  end
end
