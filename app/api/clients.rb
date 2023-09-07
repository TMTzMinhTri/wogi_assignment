# frozen_string_literal: true

class Clients < RootAPI
  resources :clients do
    desc "Create a new client"
    params do
      requires :name, type: String
      requires :email, type: String
    end
    post do
      authenticate_admin

      user = User.new(declared_params)
      user.client!
      present user, with: Entities::User
    end

    route_param :id do
      desc "Set products available for client"
      params do
        requires :product_ids, type: [Integer]
      end
      post do
        authenticate_admin
        client = User.for_client.find(params[:id])
        client.product_ids = declared_params[:product_ids]
        present client
      end
    end
  end
end
