class CreateIdioms < ActiveRecord::Migration
  def self.up
    create_table :idioms do |t|
      t.string :name
      t.string :level
      t.integer :resume_id

      t.timestamps
    end
  end

  def self.down
    drop_table :idioms
  end
end
