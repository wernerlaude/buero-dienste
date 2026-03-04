Rails.application.routes.draw do
  root "pages#index"

  get "fragen-und-antworten", to: "pages#faq", as: "faq"
  get "hilfreiche-links", to: "links#index", as: "links"
  get "ueber-uns",  to: "pages#about", as: "about"
  get "werbung" => "pages#werbung", as: "werbung"
  get "datenschutz" => "pages#datenschutz"
  get "impressum" => "pages#impressum"

  resources :bundeslands, only: :show, path: "buerodienstleister-in-ihrem-bundesland"
  resources :offers, only: %i[show], path: "angebot"
  resources :users, only: %i[show], path: "ihr-partner"

  resources :users, only: %i[new create], path: "visitenkarte-buchen"

  get "up" => "rails/health#show", as: :rails_health_check
end
