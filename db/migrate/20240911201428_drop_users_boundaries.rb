class DropUsersBoundaries < ActiveRecord::Migration[7.2]
  def change
    drop_table("users_boundaries")
  end
end
