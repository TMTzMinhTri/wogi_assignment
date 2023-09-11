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
class User < ApplicationRecord
  attr_accessor :temp_password

  has_secure_password
  has_secure_token :authenticate_token, length: 36

  enum role: { admin: 0, client: 1 }

  has_many :product_access_controls
  has_many :products, through: :product_access_controls
  has_many :user_cards
  has_many :cards, through: :user_cards

  after_initialize :generate_temp_password, if: proc { new_record? && password.blank? }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true, presence: true, on: :create

  scope :for_client, -> { where(role: :client) }

  private

  def generate_temp_password
    self.temp_password = SecureRandom.base64(6).tr("+/=lIO0", "pqrsxyz")
    self.password = temp_password
  end

  class << self
    def authenticate(params)
      return find_by(authenticate_token: params[:access_token]) if params[:access_token]

      account = find_by(email: params[:email])
      return unless account&.authenticate(params[:password])

      account
    end

    def authenticate!(params)
      account = authenticate(params)
      raise ApplicationError, "Email or Password not correct" unless account

      account.regenerate_authenticate_token if account.authenticate_token.blank?

      account
    end
  end
end
