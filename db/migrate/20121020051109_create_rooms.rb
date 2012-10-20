class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :user_id
      t.string :title
      t.string :permission

      t.timestamps
    end
  end
end
