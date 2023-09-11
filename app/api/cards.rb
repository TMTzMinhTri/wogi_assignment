# frozen_string_literal: true

class Cards < RootAPI
  resources :clients do
    resources :cards do
      desc "Buy a card from product"
      params do
        requires :card_id, type: String
      end
      post do
        authenticate_user
        user_card = current_user.user_cards.build(declared_params)
        user_card.save!
        present user_card, with: Entities::UserCard
      end

      desc "Get reports encompassing spending and card cancellation activities"
      params do
        requires :filter_by, type: String, values: ["date", "week", "month"], default: "date"
      end
      get do
        authenticate_admin
        filter_by = declared_params.fetch(:filter_by, "date")

        values = if filter_by == "week"
          {
            spending: UserCard.includes(:card).without_cancelled.for_week.group_by do |u|
                        u.created_at.strftime("%m/%d/%Y")
                      end.transform_values do |user_cards|
                        user_cards.map do |user_card|
                          user_card.card.amount_cents
                        end.sum
                      end,

            cancellation: UserCard.includes(:card).only_cancelled.for_week.group_by do |u|
                            u.created_at.strftime("%m/%d/%Y")
                          end.transform_values(&:count),
          }
        elsif filter_by == "month"
          {
            spending: UserCard.includes(:card).without_cancelled.for_month.group_by do |u|
                        u.created_at.strftime("%m/%d/%Y")
                      end.transform_values do |user_cards|
                        user_cards.map do |user_card|
                          user_card.card.amount_cents
                        end.sum
                      end,
            cancellation: UserCard.includes(:card).only_cancelled.for_month.group_by do |u|
                            u.created_at.strftime("%m/%d/%Y")
                          end.transform_values(&:count),
          }
        else
          {
            spending: UserCard.includes(:card).without_cancelled.for_today.group_by do |u|
                        u.created_at.strftime("%m/%d/%Y")
                      end.transform_values do |user_cards|
                        user_cards.map do |user_card|
                          user_card.card.amount_cents
                        end.sum
                      end,
            cancellation: UserCard.includes(:card).only_cancelled.for_today.group_by do |u|
                            u.created_at.strftime("%m/%d/%Y")
                          end.transform_values(&:count),
          }
        end

        present values, with: Entities::CardReport
      end

      route_param :id do
        desc "cancle card"
        delete do
          authenticate_user
          card = current_user.user_cards.find(params[:id])
          raise ApplicationError, "Card already cancelled" unless card.cancelled_at.nil?

          card.update!(cancelled_at: Time.current)
          present card, with: Entities::UserCard
        end
      end
    end
  end
end
