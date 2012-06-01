class CreateEducations < ActiveRecord::Migration
  def self.up
    create_table :educations do |t|
      t.integer :resume_id
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :degree_level

      t.timestamps
    end
  end

  def self.down
    drop_table :educations
  end
end
