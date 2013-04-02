class CreateInterviewsTypes < ActiveRecord::Migration
  def up
   create_table :interviews_types do |t|
     t.integer :id
     t.string :description

     t.timestamps
   end
  end

  def down
    drop_table :interviews_types
  end
end