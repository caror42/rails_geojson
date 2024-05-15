class AddUniqueConstraintToBoundaryName < ActiveRecord::Migration[7.1]
  def change
    add_index :boundaries, :name, unique: true
  end
end
