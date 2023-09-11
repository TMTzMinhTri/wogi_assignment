# frozen_string_literal: true

class CreateUserCards < ActiveRecord::Migration[7.0]
  def change
    create_table(:user_cards) do |t|
      t.references(:user)
      t.references(:card)
      t.datetime(:deleted_at)
      t.datetime(:cancelled_at)
      t.timestamps
    end
    add_column(:users, :user_cards_count, :integer, default: 0)
  end
end
