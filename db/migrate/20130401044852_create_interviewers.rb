class CreateInterviewers < ActiveRecord::Migration
  def change
   create_table :interviewers do |t|
     t.string :name

     t.timestamps
   end
  end

end