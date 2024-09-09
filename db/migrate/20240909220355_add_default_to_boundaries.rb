class AddDefaultToBoundaries < ActiveRecord::Migration[7.2]
  def change
    change_column_default :boundaries, :is_public, from: nil, to: true
  end
end
