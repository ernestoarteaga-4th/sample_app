class DropFollowingTable < ActiveRecord::Migration
  def self.up
    drop_table :followings
  end

  def self.down
  end
end
