require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'returns invoice # as an integer'
  it 'can not have a template service'
  it 'has a hash called transaction details' do
    @transaction = Transaction.new

    @transaction.transaction_details = {"hello" => 123}
    @transaction.save

    @test = Transaction.find 1

    expect(@test.get_detail "hello").to eq 123
  end

  it 'can set a new detail at runtime' do
    @transaction = Transaction.create

    @transaction.set_detail "jolly", "anpeng"
    @transaction.save

    @test = Transaction.find 1

    expect(@test.get_detail "jolly").to eq "anpeng"
  end
end
