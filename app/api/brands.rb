# frozen_string_literal: true

class Brands < RootAPI
  resources :brands do
    desc "Get list brands"
    params do
      use :pagination
    end
    get do
      brands = Brand.all
      results = pagination_values(brands)
      present results[:pagination], with: Entities::Pagination
      present results[:data], with: Entities::Brand
    end

    desc "Create new brand"
    params do
      requires :name, type: String
      optional :description, type: String
      requires :website, type: String
      requires :is_published, type: Boolean
    end
    post do
      brand = Brand.create!(declared_params)
      present brand, with: Entities::Brand
    end

    route_param :id do
      desc "Get details of brand"
      get do
        brand = Brand.find(params[:id])
        present brand, with: Entities::Brand
      end

      desc "Update brand"
      params do
        optional :name, type: String
        optional :description, type: String
        optional :website, type: String
        optional :is_published, type: Boolean
      end
      put do
        brand = Brand.find(params[:id])
        brand.assign_attributes(declared_params)
        brand.save!

        present brand, with: Entities::Brand
      end

      desc "Delete brand"
      delete do
        brand = Brand.find(params[:id])
        brand.update_columns(deleted_at: Time.current)
        present brand, with: Entities::Brand
      end
    end
  end
end
