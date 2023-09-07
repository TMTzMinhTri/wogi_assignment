# frozen_string_literal: true

class Products < RootAPI
  resources :products do
    desc "Get list Products"
    params do
      use :pagination
      optional :brand_id, type: String
      requires :currency,
        type: String,
        values: EuCentralBank::CURRENCIES,
        default: "USD"
    end
    get do
      authenticate_user

      products = if current_user.client?
        current_user.products.for_listing
      else
        Product.for_listing
      end
      products = products.with_brand(declared_params[:brand_id]) if declared_params[:brand_id].present?
      results = pagination_values(products)

      present results[:pagination], with: Entities::Pagination
      present results[:data], with: Entities::Product, currency: declared_params[:currency]
    end

    desc "Create new product"
    params do
      requires :name, type: String
      requires :description, type: String
      requires :brand_id, type: String
      requires :price, type: Float
    end
    post do
      authenticate_admin
      product = Product.create!(declared_params)
      present product, with: Entities::Product
    end

    route_param :id do
      desc "Get details of product"
      get do
        authenticate_admin
        product = Product.find(params[:id])
        present product, with: Entities::Product
      end

      desc "Update product"
      params do
        requires :name, type: String
        requires :description, type: String
        requires :brand_id, type: String
        requires :price, type: Float
      end
      put do
        authenticate_admin
        product = Product.find(params[:id])
        product.assign_attributes(declared_params)
        product.save!
        present product, with: Entities::Product
      end

      desc "Delete product"
      delete do
        authenticate_admin
        product = Product.find(params[:id])
        product.update_columns(deleted_at: Time.current)
        status 200
        present product, with: Entities::Product
      end
    end
  end
end
