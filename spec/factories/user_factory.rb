FactoryBot.define do
  factory :user do
    email { 'johndoe@example.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
  end

  factory :second_user, class: 'User' do
    email { 'johndoe2@example.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
