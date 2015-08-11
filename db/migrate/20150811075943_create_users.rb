class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :username

      t.timestamps null: false
    end
  end
end
