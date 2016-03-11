class Client < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :transactions

  validates :email, presence: true, email: true

  def self.search(query)
    where('company_name like ?', "%#{query}%")
  end

  def user_email
    user.email
  end

  def total_balance_of_transaction
    transactions.inject(0) {|sum, transaction| sum + transaction.total_balance}
  end
end
