# frozen_string_literal: true

GrapeSwaggerRails.options.url = '/api/swagger'
GrapeSwaggerRails.options.app_url = URI::HTTP.build(Rails.application.routes.default_url_options).to_s
GrapeSwaggerRails.options.before_filter_proc =
  proc {
    GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
  }

GrapeSwaggerRails.options.api_auth = 'Bearer' # Or 'bearer' for OAuth
GrapeSwaggerRails.options.api_key_name = 'Authorization'
GrapeSwaggerRails.options.api_key_type = 'header'
