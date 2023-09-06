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
class Brand < ApplicationRecord
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :website, presence: true

  before_create :set_random_rating_for_example

  scope :is_published, -> { where(is_published: true) }
  default_scope -> { where(deleted_at: nil) }

  private

  def set_random_rating_for_example
    self.rating = rand(0.5..5.0).round(2)
  end
end
