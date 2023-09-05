# frozen_string_literal: true

class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table(:brands) do |t|
      t.string(:name)
      t.text(:description)
      t.integer(:products_count, default: 0)
      t.string(:website)
      t.boolean(:is_published, default: true)
      t.float(:rating)
      t.timestamps
    end
    add_index(:brands, :name, unique: true)
  end
end
