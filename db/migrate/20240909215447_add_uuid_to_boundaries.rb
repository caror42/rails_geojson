class AddUuidToBoundaries < ActiveRecord::Migration[7.2]
  def change
    add_column :boundaries, :uuid, :uuid
  end
end
