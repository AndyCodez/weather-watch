require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many locations' do
      user = User.reflect_on_association(:locations)
      expect(user.macro).to eq(:has_many)
    end
  end
end
