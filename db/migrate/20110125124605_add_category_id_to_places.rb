class AddCategoryIdToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :category_id, :integer
  end

  def self.down
    remove_column :places, :category_id
  end
end
