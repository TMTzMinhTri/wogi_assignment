# frozen_string_literal: true

module Entities
  class UserCard < Entities::Base
    expose :id
    expose :card, using: Entities::Card
    expose :user, using: Entities::User
  end
end
