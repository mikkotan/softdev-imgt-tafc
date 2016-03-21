class ProvisionalReceipt < ActiveRecord::Base
  belongs_to :tx, class_name: "Transaction", foreign_key: 'transaction_id'

  validates :receipt_no, presence: true, uniqueness: true
  validates :amount_paid, numericality: { greater_than_or_equal_to: 0 }
  
end
