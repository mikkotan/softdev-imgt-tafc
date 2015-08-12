require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.new(password: 'abcd',
                     username: 'anpeng',
                     password_confirmation: 'abcd',
                     first_name: 'Anfernee',
                     last_name: 'Ng',
                     role: 'employee')
    @user.save
  end

  it 'actually creates a user' do
    expect(@user.username).to eq User.find_by(username: 'anpeng').username
  end

  it 'has its password encrypted in database' do
    expect('abcd').not_to eq User.find_by(username: 'anpeng').crypted_password
  end
end
