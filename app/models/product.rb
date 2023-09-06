# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
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
  monetize :price_cents, as: "price", numericality: { greater_than_or_equal_to: 0 }

  default_scope -> { where(deleted_at: nil) }
end
