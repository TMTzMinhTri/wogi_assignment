# frozen_string_literal: true

module Entities
  class CardReport < Entities::Base
    expose :spending
    expose :cancellation
  end
end
