class CreateEducationDegrees < ActiveRecord::Migration
  def up
    create_table :education_degrees do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.boolean :approved_flag
      t.string :approved_by

      t.timestamps
   end
  end

  def down
    drop_table :education_degrees
  end
end