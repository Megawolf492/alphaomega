class CreateHirings < ActiveRecord::Migration
  def change
    create_table :hirings do |t|
      t.integer :student_id
      t.integer :tutor_id
      t.timestamps
    end
  end
end
