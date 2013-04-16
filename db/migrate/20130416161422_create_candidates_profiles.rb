class CreateCandidatesProfiles < ActiveRecord::Migration
  def change
    create_table :candidates_profiles do |t|
	  t.integer :candidate_id
	  t.integer :profile_id
	  t.text :summary
      t.timestamps
    end
  end
end
