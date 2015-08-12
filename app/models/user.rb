class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  acts_as_authentic
end
