class AddTrailAndParkColumnsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :trail, :string
    add_column :posts, :park, :string
  end
end
