class Client < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with EmailValidator

  belongs_to :user
  has_many :transactions

  validates :email, uniqueness: true, presence: true

  def self.search(query)
    where('company_name like ?', "%#{query}%")
  end

  def user_email
    user.email
  end
end
