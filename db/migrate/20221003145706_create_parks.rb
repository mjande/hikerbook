# frozen_string_literal: true

class CreateParks < ActiveRecord::Migration[7.0]
  def change
    create_table :parks do |t|
      t.string :name, null: false
      t.string :url

      t.timestamps
    end
  end
end
