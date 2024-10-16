class AddIndexToUserBoundary < ActiveRecord::Migration[7.2]
  def change
    add_index :boundaries_users, :user_id
  end
end
