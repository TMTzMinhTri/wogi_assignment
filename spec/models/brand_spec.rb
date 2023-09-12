# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  description    :text
#  is_published   :boolean          default(TRUE)
#  name           :string
#  products_count :integer          default(0)
#  rating         :float
#  website        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_brands_on_name  (name) UNIQUE
#
require "rails_helper"

RSpec.describe(Brand, type: :model) do
  context "associations" do
    it { should have_many(:products) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:website) }
  end
end
