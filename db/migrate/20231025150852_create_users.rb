class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit 50
      t.string :username, null: false, limit 30
      t.string :email, limit 50
      t.integer :rol, null: false, default: 1
      t.string :password_digest, null: false
      t.boolean :active, null:false, default: true

      t.timestamps
    end
  end
end
