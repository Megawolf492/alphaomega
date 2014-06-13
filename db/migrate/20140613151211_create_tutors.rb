class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
	    t.string :firstName
      t.string :lastName
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.integer :zipcode
      t.integer :phone
      t.date :dob
      t.binary :gender #0 = male, 1 = female
      t.decimal :wage
      t.text :biography
      t.integer :privacy
      t.integer :status, default: 2 #0 = active, 1 = suspended, 2 = unconfirmed
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
    add_index :tutors, :email, unique: true
    add_index :tutors, :remember_token
  end
end
