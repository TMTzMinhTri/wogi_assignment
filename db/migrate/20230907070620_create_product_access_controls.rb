# frozen_string_literal: true

class CreateProductAccessControls < ActiveRecord::Migration[7.0]
  def change
    create_table(:product_access_controls, id: false) do |t|
      t.references(:user, foreign_key: true)
      t.references(:product, foreign_key: true)
    end
  end
end
