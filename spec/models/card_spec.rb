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
require "rails_helper"

RSpec.describe(Card, type: :model) do
  context "associations" do
    it { should have_many(:user_cards) }
    it { should have_many(:users).through(:user_cards) }
    it { should belong_to(:product).counter_cache(true) }
  end

  context "validations" do
    subject { build(:card) }
    it { should validate_length_of(:pin).is_equal_to(6) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end
end
