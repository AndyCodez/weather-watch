require "rails_helper"
RSpec.describe DashboardController, type: :controller do
  describe "GET #search_locations" do
    context "when user is authenticated" do
      before do
        user = FactoryBot.create(:user)
        sign_in user
      end

      it "assigns empty array to @locations if search query is blank" do
        get :search_locations, params: { search_query: "" }
        expect(assigns(:locations)).to eq([])
      end

      it "assigns locations to @locations if search query is present" do
        locations = ["London, GB", "London, CA"]
        allow(SearchLocations).to receive(:call).and_return(locations)
        get :search_locations, params: { search_query: "London" }
        expect(assigns(:locations)).to eq(locations)
      end

      it "renders the view with a flash message if location is not found" do
        allow(SearchLocations).to receive(:call).and_return([])
        get :search_locations, params: { search_query: "Some nonexistent location" }
        expect(response).to render_template(:search_locations)
        expect(flash[:warning]).to eq("Location not found")
      end

      it "responds with JSON data if format is json" do
        locations = ["London, GB", "London, CA"]
        allow(SearchLocations).to receive(:call).and_return(locations)
        get :search_locations, params: { search_query: "London" }, format: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
        json = JSON.parse(response.body)
        expect(json["locations"]).to eq(locations)
      end

      it "responds with error JSON data if location not found and format is json" do
        allow(SearchLocations).to receive(:call).and_return([])
        get :search_locations, params: { search_query: "Some Nonexistent Location" }, format: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Location not found")
        expect(response).to have_http_status(:not_found)
      end

      it "responds with error JSON data if location not found and format is json" do
        allow(SearchLocations).to receive(:call).and_return([])
        get :search_locations, params: { search_query: "Some Nonexistent Location" }, format: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Location not found")
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user is not authenticated" do
      it "redirects to sign-in page" do
        get :search_locations, params: { search_query: "San Francisco" }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
