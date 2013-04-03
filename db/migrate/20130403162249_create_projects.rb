class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :resume_id
      t.string :company_name
      t.string :job_position
      t.date :start_date
      t.date :end_date
      t.string :description

      t.timestamps
    end
  end
end
