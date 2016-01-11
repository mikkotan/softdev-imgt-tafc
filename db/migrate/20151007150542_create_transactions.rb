class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :billing_num
      t.float :retainers_fee
      t.float :vat
      t.float :percentage
      t.float :withholding_1601c
      t.float :withholding_1601e
      t.float :employee_benefit_sss
      t.float :employee_benefit_philhealth
      t.float :employee_benefit_pag_ibig
      t.belongs_to :client, index: true
      t.timestamps null: false
    end
  end
end
