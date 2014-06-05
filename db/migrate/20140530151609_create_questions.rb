class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.string :difficulty
      t.integer :maxValue
      t.integer :quiz_id
      t.timestamps
    end
  end
end
