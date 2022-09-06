class ChangeBodyToDescriptionInPost < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :body, :description
  end
end
