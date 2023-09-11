# frozen_string_literal: true

class AddCardsCountToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column(:products, :cards_count, :integer)
  end
end
