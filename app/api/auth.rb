# frozen_string_literal: true

class Auth < RootAPI
  resources :auth do
    get "me" do
      authenticate_user
      present current_user, with: Entities::User
    end

    params do
      requires :user, type: Hash do
        requires :email, type: String
        requires :password, type: String
      end
    end
    post "login" do
      user = User.authenticate!(declared_params[:user])
      extra_infos = {
        authenticate_token: user.authenticate_token,
      }
      present extra_infos
      present user, with: Entities::User
    end

    params do
      requires :user, type: Hash do
        requires :email, type: String
        requires :name, type: String
        requires :password, type: String
      end
    end
    post "register" do
      user = User.new(declared_params)
      user.role = "client"
      user.save!
      extra_infos = {
        authenticate_token: user.authenticate_token,
      }
      present extra_infos
      present user, with: Entities::User
    end

    delete "logout" do
      authenticate_user
      current_user.update!(authenticate_token: nil)

      status 200
    end
  end
end
