class CreateCandidateProfileTags < ActiveRecord::Migration
  def change
    create_table :candidate_profile_tags do |t|
      t.integer :candidate_profiles_id
      t.integer :project_tags_id

      t.timestamps
    end
  end
end
