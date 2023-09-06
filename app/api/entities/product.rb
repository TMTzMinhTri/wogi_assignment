# frozen_string_literal: true

module Entities
  class Product < Entities::Base
    expose :id
    expose :name
    expose :description
    expose :price
    expose :price_by_currency do |instance, options|
      instance.price_by_currency(options[:currency] || "USD")
    end
    expose :price_display
    expose :rating
    expose :created_at
    expose :brand, using: Entities::Brand
  end
end
