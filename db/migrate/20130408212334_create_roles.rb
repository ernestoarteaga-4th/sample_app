class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.boolean :approved_flag
      t.string :approved_by

      t.timestamps
    end

  Role.create(:name => 'Developer', :description => 'Responsible of make applications.', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => 'Manager', :description => 'Responsible of coordinate the team.', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => 'Tester', :description => 'Responsible of test applications', :approved_flag => 1, :approved_by => 'System')
  
  end
end
