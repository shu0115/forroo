class AddMessagesCountToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :messages_count, :integer, null: false, default: 0
  end
end
