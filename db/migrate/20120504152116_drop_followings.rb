class DropFollowings < ActiveRecord::Migration
  def self.up
    drop_table :followings
  end

  def self.down
    drop_table :followings
  end
end
