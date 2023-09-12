# frozen_string_literal: true

# == Schema Information
#
# Table name: cards
#
#  id                :bigint           not null, primary key
#  activation_number :string           not null
#  amount_cents      :integer          default(0), not null
#  amount_currency   :string           default("USD"), not null
#  deleted_at        :datetime
#  pin               :string
#  quantity          :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  product_id        :bigint
#
# Indexes
#
#  index_cards_on_activation_number  (activation_number)
#  index_cards_on_deleted_at         (deleted_at)
#  index_cards_on_product_id         (product_id)
#
class Card < ApplicationRecord
  after_initialize :set_activation_number_and_pin

  has_many :user_cards
  has_many :users, through: :user_cards
  belongs_to :product, counter_cache: true

  validates :pin, length: { is: 6 }
  monetize :amount_cents, numericality: { greater_than_or_equal_to: 0 }

  private

  def set_activation_number_and_pin
    self.activation_number = generate_uniq_activation_number
    self.pin = SecureRandom.alphanumeric(6)
  end

  def generate_uniq_activation_number
    loop do
      activation_number = SecureRandom.hex(10)

      break activation_number unless Card.where(activation_number:).exists?
    end
  end
end
