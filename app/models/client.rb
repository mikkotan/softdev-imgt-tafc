class Client < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  def self.search(query)
    where("company_name like ?", "%#{query}%")
  end
end
