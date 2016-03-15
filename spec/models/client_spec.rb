require 'rails_helper'

RSpec.describe Client, type: :model do
  it 'must have a company name'
  it 'must have an owner'
  it 'must have a representative'
  it 'must have an address'
  it 'must have a tel num'
  it 'must have a valid email'
  it 'must have a tin number'
  it 'must have a status'

  it 'gets the services correctly' do
    client = create :client
    transaction = create :transaction
    transaction2 = create :transaction, billing_num: '1001'
    create :service
    create :service, name: 'Service B', monthly_fee: 750

    transaction.other_processing_fees << Service.make(1)
    transaction.other_processing_fees << Service.make(2)

    transaction2.other_processing_fees << Service.make(1)
    transaction2.other_processing_fees << Service.make(2)

    client.transactions << transaction
    client.transactions << transaction2

    expect(client.services).to eq({'Service A' => 2, 'Service B' => 2})
  end
end
