class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :company_name
      t.string :owner
      t.string :representative
      t.text :address
      t.string :tel_num
      t.string :email
      t.string :tin_num
      t.string :status

      t.timestamps null: false
    end
  end
end
