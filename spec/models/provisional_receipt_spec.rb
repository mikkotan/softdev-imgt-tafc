require 'rails_helper'

RSpec.describe ProvisionalReceipt, type: :model do
  describe 'paid_items' do
    describe 'its relationship with amount paid' do
      let(:receipt) { build :provisional_receipt }

      context 'when they\'re actually equal' do
        subject do
          receipt
        end

        it { is_expected.to be_valid }
      end

      context 'when they\'re not equal' do
        subject do
          receipt.amount_paid = 150
          receipt
        end

        it { is_expected.to_not be_valid }
      end
    end
  end
end
