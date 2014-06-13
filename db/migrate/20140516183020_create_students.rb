class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
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
      t.text :biography
      t.integer :privacy
      t.integer :status
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
    add_index :students, :email, unique: true
    add_index :students, :remember_token
  end
end
