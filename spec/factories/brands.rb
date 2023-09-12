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
require "faker"
FactoryBot.define do
  factory :brand do
    sequence :name do |n|
      "Brand-#{n}"
    end
    website { "http://brand1.com.vn" }
    is_published { true }
    products_count { 0 }
    description { "Description" }
  end
end
