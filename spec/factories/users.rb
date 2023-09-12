# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  authenticate_token :string
#  email              :string
#  name               :string
#  password_digest    :string
#  role               :integer          default("client"), not null
#  user_cards_count   :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "client#{n}@gmail.com"
    end
    name { "Client" }
    user_cards_count { 0 }
    role { "client" }
  end
end
