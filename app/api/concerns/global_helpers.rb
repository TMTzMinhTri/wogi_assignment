# frozen_string_literal: true

module GlobalHelpers
  extend Grape::API::Helpers
  include Pagy::Backend

  params :pagination do
    optional :page, type: Integer, desc: 'Page number!'
  end

  def declared_params
    @declared_params ||= ActionController::Parameters.new(declared(params,
                                                                   include_missing: false)).permit!
  end

  def pagination_values(collection)
    pagy, data = pagy(collection, overflow: :last_page)
    {
      data:,
      pagination: pagy
    }
  end

  def login(resource)
    session = JWTSessions::Session.new(
      payload:         resource.payload,
      refresh_payload: resource.payload
    )
    tokens = session.login
    set_refresh_token(tokens.delete(:refresh),
                      tokens.delete(:refresh_expires_at))
    set_csrf_token(tokens.delete(:csrf))
    tokens
  end

  def set_csrf_token(csrf_token)
    cookies[JWTSessions.csrf_header] = {
      value: csrf_token,
      path:  '/'
    }
  end

  def set_refresh_token(refresh_token, refresh_expires_at)
    cookies[JWTSessions.refresh_cookie] = {
      value:    refresh_token,
      expires:  refresh_expires_at,
      path:     '/',
      httponly: true,
      secure:   Rails.env.production?
    }
  end

  def retrieve_csrf
    token = request_cookies[JWTSessions.csrf_header]
    raise Errors::Unauthorized, 'CSRF token is not found' unless token

    token
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
