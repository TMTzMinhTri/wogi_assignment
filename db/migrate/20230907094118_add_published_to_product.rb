# frozen_string_literal: true

class AddPublishedToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column(:products, :is_published, :boolean, default: true)
    add_index(:products, :is_published)
  end
end
