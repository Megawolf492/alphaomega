class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.timestamp :time
      t.string :location
      t.integer :duration
      t.integer :price
      t.text :tutorNote
      t.integer :status # 0 = planned, 1 = successful, 2 = unsuccessful

      t.timestamps
    end
  end
end
