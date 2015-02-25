class CreateDoodles < ActiveRecord::Migration
  def change
    create_table :doodles do |t|
    	t.string :doodle_text
    	t.belongs_to :location
    	t.belongs_to :end_user
      t.timestamps null: false
    end
  end
end
