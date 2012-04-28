class CreateFollowings < ActiveRecord::Migration
  def self.up
    create_table :followings do |t|
      t.integer :user_id
      t.integer :follow_user

      t.timestamps
    end

    add_index :followings, :user_id
  end

  def self.down
    drop_table :followings
  end
end
