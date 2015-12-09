class Transaction < ActiveRecord::Base
  serialize :transaction_details, Hash
  belongs_to :client
  has_many :fees

  def total
    retainers_fee + vat + percentage + fees.inject(0) {|sum, item| sum + item.amount}
  end

  def set_detail(key, value)
    transaction_details[key] = value
  end

  def get_detail(key)
    transaction_details[key]
  end
end
