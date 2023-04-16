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
  end
end
