class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.string :name, null: false
      t.string  :login_id, null: false, limit: 30
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
