class CreateViewings < ActiveRecord::Migration
  def change
    create_table :viewings do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end
    add_index :viewings, :user_id
    add_index :viewings, :video_id
    add_index :viewings, [:user_id, :video_id], unique: true
  end
end
