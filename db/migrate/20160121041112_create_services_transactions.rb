class CreateServicesTransactions < ActiveRecord::Migration
  def change
    create_table :services_transactions do |t|
      t.belongs_to :service, index: true
      t.belongs_to :transaction, index: true
    end
  end
end
