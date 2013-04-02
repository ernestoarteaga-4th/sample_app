class CreateCertification < ActiveRecord::Migration
  def up
   create_table :certifications do |t|
     t.integer :id
     t.string :name
     t.string :description
     t.boolean :approved_flag
     t.string :approved_by

     t.timestamps
   end
  end

  def down
    drop_table :certifications
  end
end