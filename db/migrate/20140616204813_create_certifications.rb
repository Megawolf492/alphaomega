class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.integer :subject_id
      t.integer :tutor_id
      t.timestamps
    end
  end
end
