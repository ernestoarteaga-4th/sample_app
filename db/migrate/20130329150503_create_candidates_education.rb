class CreateCandidatesEducation < ActiveRecord::Migration
  def up
   create_table :candidates_education do |t|
      t.integer :educ_degrees_id
      t.integer :candidate_id
      t.string :title
      t.string :degree
      t.datetime :date_in
      t.datetime :date_out
      t.string :university
      t.timestamps
    end

  end

  def down
    drop_table :candidates_education
  end
end
