require 'rails_helper'

RSpec.describe User, type: :model do
  it 'must have a valid email' do
    @invalid_user = build :user, email: 'aaa'

    expect(@invalid_user).to_not be_valid
  end

  it 'must have a password of at least 8 characters long' do
    @user = build :user, password: 'pass', password_confirmation: 'pass'

    expect(@user).to_not be_valid
  end

  it 'must confirm password' do
    @user = build :user, password: 'password', password_confirmation: 'aa'

    expect(@user).to_not be_valid
  end

  it 'stores password as a hash' do
    create :user

    @user = User.find 1

    expect(@user.password_hash).to_not eq 'password'
    expect(@user.password).to be_blank
  end
end
