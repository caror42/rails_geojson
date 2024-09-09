class AddPublicToBoundary < ActiveRecord::Migration[7.2]
  def change
    add_column :boundaries, :is_public, :boolean
  end
end
