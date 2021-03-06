class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.timestamp :time
      t.string :location
      t.decimal :duration
      t.decimal :price
      t.text :tutorNote
      t.integer :tutor_id
      t.integer :status # 0 = upcoming, 1 = successful, 2 = unsuccessful

      t.timestamps
    end
    create_join_table :sessions, :students do |t|
      t.index :session_id
      t.index :student_id
    end
    create_join_table :sessions, :subjects do |t|
      t.index :session_id
      t.index :subject_id
    end
  end
end
