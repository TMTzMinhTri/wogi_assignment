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
FactoryBot.define do
  factory :product_access_control do
    association(:user)
    association(:product)
  end
end
