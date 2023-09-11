# frozen_string_literal: true

# == Schema Information
#
# Table name: product_access_controls
#
#  product_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_product_access_controls_on_product_id  (product_id)
#  index_product_access_controls_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
class ProductAccessControl < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :user_cards, through: :product

  validates_uniqueness_of :user_id, scope: :product_id
  after_destroy :remote_user_cards

  def remote_user_cards
    user_cards.destroy_all
  end
end
