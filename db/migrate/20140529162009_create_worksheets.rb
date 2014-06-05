class CreateWorksheets < ActiveRecord::Migration
  def change
    create_table :worksheets do |t|
	  t.string :name
      t.string :filename
      t.integer :topic_id
      
      t.timestamps
    end
  end
end
