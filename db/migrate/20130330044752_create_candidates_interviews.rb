class CreateCandidatesInterviews < ActiveRecord::Migration
  def up
    create_table :candidates_interviews do |t|
      t.integer :candidate_id

      t.timestamps
    end
  end

  def down
    drop_table :candidates_interviews
  end
end
