class Client < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates :email, presence: true, email: true

  def self.search(query)
    where('company_name like ?', "%#{query}%")
  end

  def user_email
    user.email
  end
end
