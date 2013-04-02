class CreateLanguageLevels < ActiveRecord::Migration
  def up
   create_table :language_levels do |t|
     t.integer :id
     t.string :name
     t.string :description
     t.boolean :approved_flag
     t.string :approved_by

     t.timestamps
   end
  end

  def down
    drop_table :language_levels
  end
end