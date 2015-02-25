class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.float :lat
    	t.float :lng
    	t.float :distance
    	t.belongs_to :doodle
      t.timestamps null: false
    end
  end
end
