require "rails_helper"

RSpec.describe City, type: :model do
  describe "validations" do
    it "is valid with a name and user" do
      user = User.create(
        email: "johndoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      city = City.create(name: "Nairobi", user_id: user.id)
      expect(city).to be_valid
    end

    it "is invalid without a name" do
      user = User.create(
        email: "johndoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      city = City.create(name: "", user_id: user.id)
      expect(city).to_not be_valid
    end

    it "is invalid without a user" do
      city = City.create(name: "", user_id: nil)
      expect(city).to_not be_valid
    end

    it "is unique for each user" do
      user = User.create(
        email: "johndoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      city1 = City.create(name: "Nairobi", user_id: user.id)
      expect(city1).to be_valid
      city2 = City.create(name: "Nairobi", user_id: user.id)
      expect(city2).to_not be_valid

      user2 = User.create(
        email: "janedoe@example.com",
        password: "password123",
        password_confirmation: "password123",
      )
      city2 = City.create(name: "Nairobi", user_id: user2.id)
      expect(city2).to be_valid
    end
  end

  describe "associations" do
    it "belongs to user" do
      city = City.reflect_on_association(:user)
      expect(city.macro).to eq(:belongs_to)
    end
  end
end
