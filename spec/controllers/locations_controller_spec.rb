require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:location) { FactoryBot.create(:location, user:) }

  before do
    sign_in user
  end

  describe 'POST add_to_favorites' do
    let(:location_params) { { name: 'New York', country_code: 'US' } }

    context 'with valid params' do
      it 'creates a new location' do
        expect do
          post :add_to_favorites, params: { location: location_params }
        end.to change(Location, :count).by(1)
      end

      it 'redirects to the favorite locations page' do
        post :add_to_favorites, params: { location: location_params }
        expect(response).to redirect_to(favorite_locations_path)
      end

      it 'sets a success flash message' do
        post :add_to_favorites, params: { location: location_params }
        expect(flash[:notice]).to eq('Added to favorites successfully.')
      end
    end

    context 'with invalid params' do
      let(:location_params) { { name: '', country_code: 'US' } }

      it 'does not create a new location' do
        expect do
          post :add_to_favorites, params: { location: location_params }
        end.not_to change(Location, :count)
      end

      it 'redirects to the favorite locations page' do
        post :add_to_favorites, params: { location: location_params }
        expect(response).to redirect_to(favorite_locations_path)
      end

      it 'sets a warning flash message' do
        post :add_to_favorites, params: { location: location_params }
        expect(flash[:warning]).to eq("Name can't be blank")
      end
    end
  end

  describe 'GET #favorite_locations' do
    it 'renders the favorite_locations template' do
      get :favorite_locations
      expect(response).to render_template(:favorite_locations)
    end

    it "assigns the current user's locations to @locations" do
      get :favorite_locations
      expect(assigns(:locations)).to eq(user.locations)
    end

    context 'when requesting JSON format' do
      it "returns a list of the current user's locations as JSON" do
        get :favorite_locations, format: :json
        json_response = JSON.parse(response.body)
        expect(json_response['locations']).to eq(user.locations.as_json)
      end
    end
  end

  describe 'DELETE #remove_from_favorites' do
    it "removes the location from the current user's favorites" do
      delete :remove_from_favorites, params: { location_id: location.id }
      expect(user.locations).not_to include(location)
    end

    it 'sets a flash notice and redirects to the favorite_locations page' do
      delete :remove_from_favorites, params: { location_id: location.id }
      expect(flash[:notice]).to eq('Location removed from favorites successfully')
      expect(response).to redirect_to(favorite_locations_path)
    end

    context 'when deleting a non-existent location' do
      it 'returns an error message' do
        expect do
          delete :remove_from_favorites, params: { location_id: 0 }
        end.not_to change(Location, :count)
        expect(response).to redirect_to(favorite_locations_path)
        expect(flash[:warning]).to be_present
        expect(flash[:warning]).to eq('Failed. Please try again.')
      end
    end

    context 'when deleting a location that belongs to another user' do
      let(:other_user) { create(:second_user) }
      let(:other_location) { create(:location, user: other_user) }

      it 'returns an error message' do
        delete :remove_from_favorites, params: { location_id: other_location.id }
        expect(response).to redirect_to(favorite_locations_path)
        expect(flash[:warning]).to eq('Failed. Please try again.')
      end
    end

    context 'when requesting JSON format' do
      it 'returns a success status and message' do
        delete :remove_from_favorites, params: { location_id: location.id }, format: :json
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Location removed from favorites successfully')
        expect(response.status).to eq(200)
      end
    end
  end
end
