# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table(:products) do |t|
      t.string(:name)
      t.text(:description)
      t.float(:rating)
      t.monetize(:price)
      t.references(:brand, foreign_key: true)
      t.timestamps
    end
  end
end
