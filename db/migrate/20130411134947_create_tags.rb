class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :type_tag
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
