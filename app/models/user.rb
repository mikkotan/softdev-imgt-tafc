class User < ActiveRecord::Base
  has_many :clients, :dependent => :restrict_with_error
  has_many :transactions, through: :clients

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, confirmation: true
  validates :password, length: { minimum: 8 }, presence: true
  validates :email, presence: true, email: true

  attr_accessor :password
  before_save :encrypt_password

  attr_accessor :password

  def encrypt_password
    return false unless @password.present?
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(@password, password_salt)
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end

  def update_info(params)
    nice = true
    params.each do |key, value|
      nice &&= update_column key, value
    end
    nice
  end

  def get_filtered_total_sales(startdate, enddate)
    transactions.where(:created_at => startdate..enddate).inject(0) {|sum, cost| sum + cost.total_balance}
  end

  def name
    [first_name, last_name].join ' '
  end

  def total_sales
    clients.inject(0) {|sum, cost| sum + cost.total_balance_of_transaction}
  end

  def client_count
    clients.size
  end

end
