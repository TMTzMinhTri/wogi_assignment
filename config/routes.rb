# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount GrapeSwaggerRails::Engine => "/swagger" unless Rails.env.production?
  mount RootAPI, at: "/api"
  # Defines the root path route ("/")
  # root "articles#index"
end
