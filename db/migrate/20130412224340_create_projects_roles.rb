class CreateProjectsRoles < ActiveRecord::Migration
  def change
    create_table :projects_roles do |t|
      t.integer :projects_id
      t.integer :roles_id
      t.date :date_in
      t.date :date_out

      t.timestamps
    end
  end
end
