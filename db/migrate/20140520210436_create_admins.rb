class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
	    t.string :firstName
      t.string :lastName
      t.string :email
      t.date :dob
      t.binary :gender #0 = male, 1 = female
      t.text :biography
      t.integer :privacy
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
    add_index :admins, :email, unique: true
    add_index :admins, :remember_token
  end
end
