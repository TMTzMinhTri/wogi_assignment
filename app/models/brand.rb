# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id             :bigint           not null, primary key
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
class Brand < ApplicationRecord
  has_many :products
  validates :name, presence: true, uniqueness: true
end
