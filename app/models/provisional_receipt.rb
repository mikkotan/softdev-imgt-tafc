class ProvisionalReceipt < ActiveRecord::Base
  belongs_to :tx, class_name: "Transaction", foreign_key: 'transaction_id'

  validates :receipt_no, presence: true, uniqueness: true
  # serialize :paid_items, Hash

  # validate :amount_paid_must_be_equal_to_sum_of_paid_items
  #
  # def amount_paid_must_be_equal_to_sum_of_paid_items
  #   unless paid_items.values.inject(:+) == amount_paid
  #     errors.add(:amount_paid, "must be equal to sum of paid_items")
  #   end
  # end
end
