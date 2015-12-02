class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.float :monthly_fee
      t.string :service_type, default: 'none'
      t.boolean :is_template, default: true

      t.timestamps null: false
    end
  end
end
