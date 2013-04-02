class CreateInterviewers < ActiveRecord::Migration
  def up
   create_table :interviewers do |t|
     t.integer :id
     t.string :name

     t.timestamps
   end
  end

  def down
    drop_table :interviewers
  end
end