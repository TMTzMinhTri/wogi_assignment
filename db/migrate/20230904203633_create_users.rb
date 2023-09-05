# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table(:users) do |t|
      t.string(:name)
      t.string(:email)
      t.string(:password_digest)
      t.string(:authenticate_token)
      t.integer(:role, default: 1, null: false)
      t.timestamps
    end

    add_index(:users, :email, unique: true)
    add_index(:users, :authenticate_token, unique: true)
  end
end
