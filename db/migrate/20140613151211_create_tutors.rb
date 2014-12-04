class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
	  t.string :displayName
      t.string :realName
      t.string :email
      t.string :location
      t.integer :zipcode
      t.integer :phone
      t.date :dob
      t.binary :gender #0 = male, 1 = female
      t.text :biography
      t.string :fileName
      t.integer :privacy
      t.integer :status, default: 0 #0 = active, 1 = suspended
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
    add_index :tutors, :email, unique: true
    add_index :tutors, :remember_token
  end
end
