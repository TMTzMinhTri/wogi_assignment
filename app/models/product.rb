# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  description    :text
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
#  index_products_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
class Product < ApplicationRecord
  belongs_to :brand, counter_cache: true
  monetize :price_cents, as: "price"
end
