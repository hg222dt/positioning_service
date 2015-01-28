class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :email
      t.string :authkey
      t.timestamps
    end
  end
end
