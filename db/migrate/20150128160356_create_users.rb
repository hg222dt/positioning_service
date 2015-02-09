class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.string :webbsite_url
      t.string :website_name
      t.string :authkey
      t.boolean :is_user_admin
      t.boolean :admin_revoked_key
      t.timestamps
    end
  end
end
