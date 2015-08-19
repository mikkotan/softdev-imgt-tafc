class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 8 }
  validates :username, length: { in: 6..20 }

  attr_accessor :password
  before_save :encrypt_password

  attr_accessor :password
  validates_confirmation_of :password
  validates_presence_of :password
  validates_uniqueness_of :username
  validates_presence_of :username

  def encrypt_password
    if @password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(@password, password_salt)
    end
  end

  def self.authenticate(username, password)
    user = find_by(username: username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end

  def signed_in?
    first_name
  end
end
