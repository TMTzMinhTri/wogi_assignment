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
require "rails_helper"

RSpec.describe(ProductAccessControl, type: :model) do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
    it { should have_many(:user_cards).through(:product) }
  end

  context "validations" do
    subject { build(:product_access_control) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:product_id).ignoring_case_sensitivity }
  end
end
