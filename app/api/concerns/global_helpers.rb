# frozen_string_literal: true

module GlobalHelpers
  extend Grape::API::Helpers
  include Pagy::Backend

  params :pagination do
    optional :page, type: Integer, desc: "Page number!"
  end

  def declared_params
    @declared_params ||= ActionController::Parameters.new(declared(
      params,
      include_missing: false,
    )).permit!
  end

  def pagination_values(collection)
    pagy, data = pagy(collection, overflow: :last_page)
    {
      data:,
      pagination: pagy,
    }
  end

  def user_authenticate!
    error!("401 Unauthorized", 401) unless current_user
  end

  def current_user
    @current_user ||= User.authenticate(access_token_param)
  end

  def access_token_param
    @access_token ||= headers["Authorization"]
    { access_token: @access_token }
  end
end
