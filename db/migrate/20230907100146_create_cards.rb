# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table(:cards) do |t|
      t.string(:activation_number, null: false, unique: true)
      t.datetime(:deleted_at)
      t.string(:pin)
      t.monetize(:amount)
      t.integer(:quantity, default: 0, null: false)
      t.references(:product)
      t.timestamps
    end

    add_index(:cards, :deleted_at)
    add_index(:cards, :activation_number)
  end
end
