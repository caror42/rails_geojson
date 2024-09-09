class AddNameToBoundary < ActiveRecord::Migration[7.2]
  def change
    add_column :boundaries, :name, :string
  end
end
