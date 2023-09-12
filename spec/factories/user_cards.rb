# frozen_string_literal: true

# == Schema Information
#
# Table name: user_cards
#
#  id           :bigint           not null, primary key
#  cancelled_at :datetime
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  card_id      :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_user_cards_on_card_id  (card_id)
#  index_user_cards_on_user_id  (user_id)
#
FactoryBot.define do
  factory :user_card do
    cancelled_at { nil }
    user
    card
  end
end
