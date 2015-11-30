FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    email 'starjirachi1@yahoo.com'
    role 'owner'
    password 'password'
    password_confirmation 'password'
  end
end
