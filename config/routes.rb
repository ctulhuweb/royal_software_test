Rails.application.routes.draw do
  get "/:user_id", to: "companies#index"
end
