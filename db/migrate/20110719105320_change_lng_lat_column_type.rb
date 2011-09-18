class ChangeLngLatColumnType < ActiveRecord::Migration
  def self.up
      change_table :places do |t|
        t.change :longitude, :float, :limit =>10
        t.change :latitude, :float, :limit => 10
      end
  end

  def self.down
      change_table :places do |t|
        t.change :longitude, :float
        t.change :latitude, :float
      end
  end
end
