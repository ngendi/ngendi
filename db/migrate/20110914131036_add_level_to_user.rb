class AddLevelToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :level, :integer, :limit => 1
  end

  def self.down
    remove_column :users, :level
  end
end
