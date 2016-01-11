class Fee < ActiveRecord::Base
  belongs_to :invoice, foreign_key: 'transaction_id', class_name: 'Transaction'
end
