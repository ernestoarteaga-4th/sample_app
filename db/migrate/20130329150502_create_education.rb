class CreateEducation < ActiveRecord::Migration
  def up
   create_table :education do |t|
      t.integer :candidate_id
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :degree
      t.string :university
      t.integer :graduation_year
      t.string :certifications
      t.timestamps
    end

  end

  def down
    drop_table :education
  end
end
