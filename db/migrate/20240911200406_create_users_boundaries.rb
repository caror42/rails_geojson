class CreateUsersBoundaries < ActiveRecord::Migration[7.2]
  def change
    create_table :users_boundaries do |t|
      t.integer :user_id, null: false
      t.integer :boundary_id, null: false
      t.timestamps
    end
  end
end
