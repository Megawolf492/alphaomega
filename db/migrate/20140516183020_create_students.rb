class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :displayName
      t.string :realName
      t.string :email
      t.string :location
      t.integer :zipcode
      t.integer :phone
      t.date :dob
      t.binary :gender #0 = male, 1 = female
      t.text :biography
      t.integer :privacy
      t.integer :status, default: 2 #0 = active, 1 = suspended, 2 = unverified
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
    add_index :students, :email, unique: true
    add_index :students, :remember_token
  end
end
