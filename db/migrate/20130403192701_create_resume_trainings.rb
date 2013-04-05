class CreateResumeTrainings < ActiveRecord::Migration
  def change
    create_table :resume_trainings do |t|
      t.string :name
      t.string :description
      t.string :year
      t.integer :resume_id

      t.timestamps
    end
  end
end
