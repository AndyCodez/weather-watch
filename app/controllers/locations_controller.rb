class LocationsController < ApplicationController
  def add_to_favorites
    location = current_user.locations.build(name: params[:location_name])
    if location.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Added to favorites successfully."
          redirect_to favorite_locations_path
        }
      end
    else
      respond_to do |format|
        format.html {
          redirect_to favorite_locations_path
        }
      end
    end
  end

  def favorite_locations
    @locations = current_user.locations
  end

  def remove_from_favorites
    location = location.find(params[:location_id])
    location.destroy!
    respond_to do |format|
      format.html { redirect_to favorite_locations_path }
    end
  end
end
