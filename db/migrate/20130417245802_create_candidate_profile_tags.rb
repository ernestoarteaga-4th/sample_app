class CreateCandidateProfileTags < ActiveRecord::Migration
  def change
    create_table :candidate_profile_tags do |t|
      t.integer :candidate_profiles_id
      t.integer :projects_roles_id
      t.integer :tags_id

      t.timestamps
    end
  end
end
