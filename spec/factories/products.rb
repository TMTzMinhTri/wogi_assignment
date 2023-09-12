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
FactoryBot.define do
  factory :product do
    sequence :name do |n|
      "Product #{n}"
    end
    description { "Product Description" }
    price { 10 }
    cards_count { 0 }
    brand
  end
end
