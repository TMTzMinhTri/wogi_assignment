# frozen_string_literal: true

module Entities
  class User < Entities::Base
    expose :id
    expose :name
    expose :email
    expose :role
    expose :temp_password
    expose :user_cards_count
  end
end
