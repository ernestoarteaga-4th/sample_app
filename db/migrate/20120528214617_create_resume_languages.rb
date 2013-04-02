class CreateResumeLanguagues < ActiveRecord::Migration
  def change
    create_table :resume_languagues do |t|
      t.string :name
      t.string :level
      t.integer :resume_id

      t.timestamps
    end
  end

end
