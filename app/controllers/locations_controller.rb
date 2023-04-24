class LocationsController < ApplicationController
  def add_to_favorites
    location = current_user.locations.build(name: params[:location][:name], country_code: params[:location][:country_code])
    if location.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Added to favorites successfully."
          redirect_to favorite_locations_path
        }
        format.json { render json: { status: "success", message: "Added to favorites successfully" }, status: :ok }
      end
    else
      respond_to do |format|
        format.html {
          flash[:warning] = "#{location.errors.full_messages[0]}"
          redirect_to favorite_locations_path
        }
        format.json { render json: { status: "error", message: "#{location.errors.full_messages[0]}" }, status: :unprocessable_entity }
      end
    end
  end

  def favorite_locations
    @locations = current_user.locations
    respond_to do |format|
      format.html
      format.json { render json: { locations: @locations } }
    end
  end

  def remove_from_favorites
    location = Location.find(params[:location_id])
    location.destroy!

    respond_to do |format|
      format.html {
        flash[:notice] = "Location removed from favorites successfully"
        redirect_to favorite_locations_path
      }
      format.json { render json: { message: "Location removed from favorites successfully" }, status: :ok }
    end
  end
end
