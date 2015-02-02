class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :webbsite_url
      t.string :website_name
      t.string :authkey
      t.timestamps
    end
  end
end
