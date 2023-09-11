# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  cards_count    :integer
#  deleted_at     :datetime
#  description    :text
#  is_published   :boolean          default(TRUE)
#  name           :string
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("USD"), not null
#  rating         :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  brand_id       :bigint
#
# Indexes
#
#  index_products_on_brand_id      (brand_id)
#  index_products_on_is_published  (is_published)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#

require "money-rails/helpers/action_view_extension"

class Product < ApplicationRecord
  include MoneyRails::ActionViewExtension

  before_create :set_random_rating_for_example
  after_create :create_card_with_default_price_and_quantity

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: { scope: :brand_id }

  belongs_to :brand, counter_cache: true
  has_many :product_access_controls
  has_many :users, through: :product_access_controls
  has_many :cards
  has_many :user_cards, through: :cards

  default_scope -> { where(deleted_at: nil) }
  scope :with_brand, ->(brand_id) { where(brand: brand_id) }
  scope :for_listing, -> { includes(:brand) }
  scope :with_published, -> { where(is_published: true) }

  def price_by_currency(currency = "USD")
    price.exchange_to(currency) unless currency == "USD"
    price
  end

  def price_display
    humanized_money_with_symbol(price_by_currency)
  end

  private

  def set_random_rating_for_example
    self.rating = rand(0.5..5.0).round(2)
  end

  def create_card_with_default_price_and_quantity
    default_price = [10, 20, 30, 40, 50]
    cards = default_price.map { |p| { quantity: 10, amount: p, product_id: id } }
    Card.create!(cards)
  end
end
