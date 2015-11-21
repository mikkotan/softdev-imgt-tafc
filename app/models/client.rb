class Client < ActiveRecord::Base
  belongs_to :user

  def user_email
    user.email
  end
end
