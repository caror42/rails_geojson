class CreateJoinTableUserBoundary < ActiveRecord::Migration[7.2]
  def change
    create_join_table :users, :boundaries
  end
end
