# frozen_string_literal: true

module Entities
  class Brand < Entities::Base
    expose :id
    expose :name
    expose :description
    expose :website
    expose :rating
    expose :products_count
    # expose :is_published
    expose :created_at
  end
end
