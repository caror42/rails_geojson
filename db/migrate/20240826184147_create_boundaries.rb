class CreateBoundaries < ActiveRecord::Migration[7.2]
  def change
    create_table :boundaries do |t|
      t.float :minx
      t.float :maxx
      t.float :miny
      t.float :maxy
      t.jsonb :coordinates

      t.timestamps
    end
  end
end
