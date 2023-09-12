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
FactoryBot.define do
  factory :card do
    deleted_at { nil }
    quantity { 10 }
    product
    amount { 10 }
  end
end
