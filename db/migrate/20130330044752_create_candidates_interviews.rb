class CreateCandidatesInterviews < ActiveRecord::Migration
  def up
    create_table :candidates_interviews do |t|
      t.integer :id
      t.integer :candidate_id
      t.string :result
      t.integer :interviewer_id
      t.integer :interview_type_id
      t.string :comments

      t.timestamps
    end
  end

  def down
    drop_table :candidates_interviews
  end
end
