class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.string :approved_flag
      t.string :approved_by

      t.timestamps
    end
  end
end
