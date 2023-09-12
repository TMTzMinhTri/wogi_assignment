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
require "rails_helper"

RSpec.describe(UserCard, type: :model) do
  let(:user) { create(:user) }
  let(:brand) { create(:brand) }
  let(:product) { create(:product, brand: brand) }
  let(:card) { create(:card, product: product) }

  let(:product_access_control) { create(:product_access_control, user: user, product: product) }

  subject { build(:user_card, card: card, product: product) }

  context "associations" do
    it { should belong_to(:user).counter_cache(true) }
    it { should belong_to(:card) }
    it { should have_one(:product).through(:card) }
  end

  context "validations" do
    it { should validate_uniqueness_of(:card_id).scoped_to(:user_id).ignoring_case_sensitivity }
    it do
      expect(subject.product).to(be_present)
    end

    it "is expected to validate card quantity available" do
      subject.card.quantity = 0
      subject.validate
      expect(subject.errors[:base]).to(include("Card out of stock"))
    end

    it "it expected valid product" do
      new_user = create(:user)
      subject.user_id = new_user.id
      subject.validate
      expect(subject.errors[:base]).to(include("Product not available for this user"))
    end
  end
end
