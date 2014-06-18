class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.integer :grade
      t.integer :status, default: 0 #0 = failed, 1 = passed/unconfirmed, 2 = confirmed
      t.integer :subject_id
      t.integer :tutor_id
      t.timestamps
    end
  end
end
