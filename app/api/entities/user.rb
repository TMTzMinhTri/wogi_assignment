# frozen_string_literal: true

module Entities
  class User < Entities::Base
    expose :id
    expose :name
    expose :email
    expose :role
    expose :temp_password
  end
end
