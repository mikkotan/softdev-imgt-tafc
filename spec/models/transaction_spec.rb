require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'billing #' do
    it 'is required' do
      @transaction = build :transaction, billing_num: ''

      expect(@transaction).to_not be_valid
    end
  end

  describe 'vat and percentage' do
    context 'when vat is filled in' do
      let(:transaction) { build :transaction, vat: 500 }
      context 'and percentage is not' do
        subject do
          transaction.percentage = 0
          transaction
        end

        it { is_expected.to be_valid }
      end

      context 'and percentage is also filled in' do
        subject do
          transaction.percentage = 100
          transaction
        end

        it { is_expected.to_not be_valid }
      end
    end

    context 'when percentage is filled in' do
      let(:transaction) { build :transaction, percentage: 500 }
      context 'and vat is not' do
        subject do
          transaction.vat = 0
          transaction
        end

        it { is_expected.to be_valid }
      end
    end
  end

  it 'has withholding 1601C and 1601E fees' do
    create :transaction, withholding_1601c: 500, withholding_1601e: 300
    @transaction = Transaction.find 1

    expect(@transaction.withholding_1601c).to eq 500
    expect(@transaction.withholding_1601e).to eq 300
  end

  it 'has employee benefits (sss, philhealth, pag-ibig)' do
    create :transaction, employee_benefit_sss: 300,
     employee_benefit_philhealth: 100, employee_benefit_pag_ibig: 200
    @transaction = Transaction.find 1

    expect(@transaction.employee_benefit_pag_ibig).to eq 200
    expect(@transaction.employee_benefit_philhealth).to eq 100
    expect(@transaction.employee_benefit_sss).to eq 300
  end

  describe 'other processing fees' do
    before(:each) do
      create :service # monthly_fee = 5000
      create :service, name: 'Service B', monthly_fee: 750
    end

    let(:transaction) {build :transaction}

    it 'is present in the model' do
      transaction.other_processing_fees << Service.make(1)
      transaction.other_processing_fees << Service.make(2)

      expect(transaction.other_processing_fees[0].monthly_fee).to eq 5000
      expect(transaction.other_processing_fees[1].monthly_fee).to eq 750
    end

    describe 'template service validation' do
      context 'when at least one template service is present' do
        subject do
          transaction.other_processing_fees << Service.make(1)
          transaction.other_processing_fees << Service.find(2)
          transaction
        end

        it { is_expected.to_not be_valid }
      end

      context 'when all are non-template services' do
        subject do
          transaction.other_processing_fees << Service.make(1)
          transaction.other_processing_fees << Service.make(2)
          transaction
        end

        it { is_expected.to be_valid }
      end
    end

    describe '.total_of_processing_fees' do
      it 'gets total of other processing fees' do
        transaction.other_processing_fees << Service.make(1)
        transaction.other_processing_fees << Service.make(2)

        expect(transaction.total_of_processing_fees).to eq 5750
      end
    end
  end

  it 'can get the list of services' do
    a = create :transaction

    create :service
    create :service, name: 'Service B', monthly_fee: 750

    a.other_processing_fees << Service.make(1)
    a.other_processing_fees << Service.make(2)

    expect(a.service_names).to eq ['Service A', 'Service B']
  end

  describe 'fees related stuff' do
    let(:transaction) do
      create :service # monthly_fee = 5000
      create :service, name: 'Service B', monthly_fee: 750

      a = create :full_transaction

      a.other_processing_fees << Service.make(1)
      a.other_processing_fees << Service.make(2)
      a # total_balance = 8450
    end

    describe '.total_balance' do
      it 'gets the total balance correctly' do
        expect(transaction.total_balance).to eq 8450
      end
    end

    describe '.get_fees' do
      it 'returns a hash of all the fees of the transaction' do
        result = { 'Retainers Fee' => 500,
          'Employee Benefit SSS' => 300,
          'Employee Benefit PhilHealth' => 100,
          'Employee Benefit Pag-ibig' => 200,
          'Withholding 1601C ' => 500,
          'Withholding 1601E' => 300,
          'VAT' => 800,
          'Percentage' => 0,
          'Other Processing Fees' => 5750 }
        expect(transaction.get_fees).to eq result
      end
    end
  end
end
