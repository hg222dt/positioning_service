class CreateDoodles < ActiveRecord::Migration
  def change
    create_table :doodles do |t|
    	t.string :doodle_text
    	t.string :coordinates
    	t.string :poster_user_id
      t.timestamps null: false
    end
  end
end
