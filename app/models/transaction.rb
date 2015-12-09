class Transaction < ActiveRecord::Base

  belongs_to :client
  has_many :fees

  def total
    retainers_fee + vat + percentage + fees.inject(0) {|sum, item| sum + item.amount}
  end
end
