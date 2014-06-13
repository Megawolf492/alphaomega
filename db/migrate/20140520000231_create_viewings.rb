class CreateViewings < ActiveRecord::Migration
  def change
    create_table :viewings do |t|
      t.integer :student_id
      t.integer :video_id

      t.timestamps
    end
    add_index :viewings, :student_id
    add_index :viewings, :video_id
    add_index :viewings, [:student_id, :video_id], unique: true
  end
end
