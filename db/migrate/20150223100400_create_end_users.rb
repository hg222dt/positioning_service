class CreateEndUsers < ActiveRecord::Migration
  def change
    create_table :end_users do |t|
    	t.string :email, :null => false
    	t.string :password_digest, :null => false
    	t.string :username
    	t.string :bio_text
      t.timestamps null: false
    end
  end
end
