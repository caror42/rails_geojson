class AddNameToBoundary < ActiveRecord::Migration[7.1]
  def change
    add_column :boundaries, :name, :string
  end
end
