# frozen_string_literal: true

module Entities
  class Product < Entities::Base
    expose :id
    expose :name
    expose :description
    expose :rating
    expose :is_published
    expose :created_at
  end
end
