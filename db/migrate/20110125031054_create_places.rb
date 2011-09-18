class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
	t.string :title
	t.text :desc
	t.text :address
	t.string :phone
	t.float :longitude
	t.float :latitude
	t.integer :rating
	t.datetime :published_at
	t.datetime :created_at
	t.datetime :updated_at	
     	t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
