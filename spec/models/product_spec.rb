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
require "rails_helper"

RSpec.describe(Product, type: :model) do
  context "associations" do
    it { should have_many(:product_access_controls) }
    it { should have_many(:users).through(:product_access_controls) }
    it { should have_many(:cards) }
    it { should have_many(:user_cards).through(:cards) }
    it { should belong_to(:brand).counter_cache(true) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:brand_id) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
