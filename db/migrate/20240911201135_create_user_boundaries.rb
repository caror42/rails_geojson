class CreateUserBoundaries < ActiveRecord::Migration[7.2]
  def change
    create_table :user_boundaries do |t|
      t.timestamps
    end
  end
end
