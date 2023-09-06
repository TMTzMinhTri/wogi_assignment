# frozen_string_literal: true

class AddDeletedAtToBrandsAndProducts < ActiveRecord::Migration[7.0]
  def change
    add_column(:brands, :deleted_at, :datetime)
    add_column(:products, :deleted_at, :datetime)
  end
end
