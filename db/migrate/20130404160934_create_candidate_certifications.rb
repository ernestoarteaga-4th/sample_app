class CreateCandidateCertifications < ActiveRecord::Migration
  def change
    create_table :candidate_certifications do |t|
      t.integer :certification_id
      t.integer :candidate_id
      t.date :year
      t.timestamps
    end
  end
end
