# frozen_string_literal: true

module Entities
  class Card < Entities::Base
    expose :id
    expose :activation_number
    expose :pin
    expose :product_id
    expose :amount_cents
    expose :amount
    expose :quantity
  end
end
