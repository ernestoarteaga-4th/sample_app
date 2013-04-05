class CreateEducDegrees < ActiveRecord::Migration
  def up
   create_table :educ_degrees do |t|
      t.string :name
      t.string :description
      t.boolean :approved_flag
      t.string :approved_by
      t.timestamps
    end

  end

  def down
    drop_table :educ_degrees
  end
end
