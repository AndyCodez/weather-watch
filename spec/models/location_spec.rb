require "rails_helper"

RSpec.describe Location, type: :model do
  describe "validations" do
    it "is valid with a name, country_code, and user" do
      user = User.create(
        email: "johndoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      location = Location.create(name: "Nairobi", country_code: "KE", user_id: user.id)
      expect(location).to be_valid
    end

    it "is invalid without a name" do
      user = User.create(
        email: "johndoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      location = Location.create(name: "", country_code: "KE", user_id: user.id)
      expect(location).to_not be_valid
    end

    it "is invalid without a country code" do
      user = User.create(
        email: "johndoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      location = Location.create(name: "Nairobi", country_code: "", user_id: user.id)
      expect(location).to_not be_valid
    end

    it "is invalid without a user" do
      location = Location.create(name: "", user_id: nil)
      expect(location).to_not be_valid
    end

    it "is unique for each user" do
      user = User.create(
        email: "johndoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      location1 = Location.create(name: "Nairobi", country_code: "KE", user_id: user.id)
      expect(location1).to be_valid
      location2 = Location.create(name: "Nairobi", country_code: "KE", user_id: user.id)
      expect(location2).to_not be_valid

      user2 = User.create(
        email: "janedoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      location2 = Location.create(name: "Nairobi", country_code: "KE", user_id: user2.id)
      expect(location2).to be_valid
    end
  end

  describe "associations" do
    it "belongs to user" do
      location = Location.reflect_on_association(:user)
      expect(location.macro).to eq(:belongs_to)
    end
  end
end
