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
require "rails_helper"

RSpec.describe(User, type: :model) do
  context "associations" do
    it { should have_many(:product_access_controls) }
    it { should have_many(:products).through(:product_access_controls) }
    it { should have_many(:user_cards) }
    it { should have_many(:cards).through(:user_cards) }
  end

  context "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("user@example.com").for(:email) }

    it { should validate_confirmation_of(:password).on(:create) }
    it { should validate_presence_of(:password).on(:create) }
  end

  describe "generate password" do
    context "when create client without password" do
      it "password default have length equal 8" do
        user = build(:user)
        if user.new_record?
          expect(user.password.length).to(eq(8))
        end
      end
    end
  end
end
