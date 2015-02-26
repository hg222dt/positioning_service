class CreateApiUserStats < ActiveRecord::Migration
  def change
    create_table :api_user_stats do |t|
    	t.belongs_to :user
      t.timestamps null: false
    end
  end
end
