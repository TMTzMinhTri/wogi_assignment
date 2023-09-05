# frozen_string_literal: true

Rails.application.config.middleware.insert_before(0, Rack::Cors) do
  allow do
    origins "localhost:3002", "127.0.0.1:3002"
    resource "*", headers: :any, methods: [:get, :post, :patch, :put], credentials: true
  end
end
