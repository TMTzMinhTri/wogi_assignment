# frozen_string_literal: true

# == Schema Information
#
# Table name: user_cards
#
#  id           :bigint           not null, primary key
#  cancelled_at :datetime
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  card_id      :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_user_cards_on_card_id  (card_id)
#  index_user_cards_on_user_id  (user_id)
#
class UserCard < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :card
  has_one :product, through: :card

  validates_uniqueness_of :card_id, scope: :user_id
  validate :card_quantity_available
  validate :product_valid

  after_update :decrement_counter_from_user, if: proc { deleted_at_changed? && deleted_at_previously_was.nil? }
  after_create :decrease_card_quantity

  scope :for_month, -> {
    where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)
  }
  scope :for_week, -> {
    where(created_at: Time.current.beginning_of_week..Time.current.end_of_week)
  }
  scope :for_today, -> {
    where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
  }
  scope :without_cancelled, -> {
    where("cancelled_at" => nil)
  }
  scope :only_cancelled, -> {
    where.not("cancelled_at" => nil)
  }

  private

  def decrement_counter_from_user
    User.decrement_counter(:user_cards_count, id)
  end

  def decrease_card_quantity
    card.decrement!(:quantity, 1)
  end

  def card_quantity_available
    if card.quantity == 0
      errors.add(:base, "Card out of stock")
      false
    end
  end

  def product_valid
    unless ProductAccessControl.exists?(product_id: product.id, user_id:)
      errors.add(:base, "Product not available for this user")
      false
    end
  end
end
