class CreateInterviewsTypes < ActiveRecord::Migration
  def change
   create_table :interviews_types do |t|
     t.string :name

     t.timestamps
   end
  end

end
