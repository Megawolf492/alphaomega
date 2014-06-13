class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.float :average
      t.text :difficulty
      t.integer :student_id
      t.integer :quiz_id
      t.timestamps
    end
    add_index :grades, :student_id
    add_index :grades, :quiz_id
  end
end
