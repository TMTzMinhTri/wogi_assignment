# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  authenticate_token :string
#  email              :string
#  name               :string
#  password_digest    :string
#  role               :integer          default(1), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_secure_token :authenticate_token, length: 36
  validates :email, presence: true, uniqueness: true,format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, confirmation: true, presence: true, on: :create

  class << self 
    def authenticate(params)
  return find_by authenticate_token: params[:access_token] if params[:access_token]
      account = find_by(email: params[:email])
      return unless account&.authenticate(params[:password])
      account
    end
    
    def authenticate!(params)
      account = authenticate(params)
      raise ApplicationError, 'Email or Password not correct' unless account

      account.regenerate_authenticate_token if account.authenticate_token.blank?

      account
    end
  end
end
