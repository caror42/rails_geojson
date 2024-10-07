class DropUserBoundary < ActiveRecord::Migration[7.2]
  def change
    drop_table("user_boundaries")
  end
end
