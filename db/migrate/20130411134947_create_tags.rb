class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :type_tag
      t.string :name
      t.string :description

      t.timestamps
    end

    Tag.create(:type_tag => 1, :name => 'NetBeans', :description => 'IDE of programation')
    Tag.create(:type_tag => 1, :name => 'Eclipse', :description => 'IDE of programation')
    Tag.create(:type_tag => 2, :name => 'Documentation', :description => 'Create documents of applications')
    Tag.create(:type_tag => 2, :name => 'TeamWork', :description => 'Working in team')
    Tag.create(:type_tag => 3, :name => 'JAVA', :description => 'Language of programation')
    Tag.create(:type_tag => 3, :name => 'Delphi', :description => 'Language of programation')
    Tag.create(:type_tag => 3, :name => '.NET', :description => 'Language of programation')
    Tag.create(:type_tag => 3, :name => 'Pascal', :description => 'Language of programation')

  end
end
