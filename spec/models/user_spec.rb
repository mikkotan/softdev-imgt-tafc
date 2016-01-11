require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when user uses an invalid email' do
    subject { build :user, email: 'aaa' }
    it { is_expected.to_not be_valid }
  end

  describe 'password' do
    context 'when it is not at least 8 characters long' do
      subject { build :user, password: 'pass', password_confirmation: 'pass' }

      it { is_expected.to_not be_valid }
    end

    context 'when it is not confirmed' do
      subject { build :user, password: 'password', password_confirmation: 'aa' }

      it { is_expected.to_not be_valid }
    end

    context 'when it is stored and tried to be retrieved' do
      before { create :user }
      let(:user) { User.find 1 }

      it 'must be in the form of a hash' do
        expect(user.password_hash).to_not eq 'password'
      end

      it 'must not be blank' do
        expect(user.password).to be_blank
      end
    end
  end
end
