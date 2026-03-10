Rails.application.routes.draw do
  root "pages#index"

  get "/angebot/ordnungssysteme-im-buero", to: redirect("/angebot/bueroservice", status: 301)
  get "/aufbewahrungsfristen" => redirect("/office-blogs/7-aufbewahrungsfristen-private-dokumente-rechnungen", status: 301)
  get "/angebot/12-schreibservice" => redirect("/angebot/12-sekretariatsservice-schreibservice", status: 301)

  get "/angebot/12-schreibservice", to: redirect("/angebot/12-sekretariatsservice-schreibservice", status: 301)
  get "/buerodienstleister-in-ihrem-bundesland/*path", to: redirect("/", status: 301)

  # DANN die Show-Route (nur einmal!)
  get "angebot/:id", to: "offers#show"
  # Ganz oben bei den Redirects
  get "/buerodienstleister-in-ihrem-bundesland/*path", to: redirect("/", status: 301)
  get "/zielgruppe/*path", to: redirect("/", status: 301)

  get "fragen-und-antworten", to: "pages#faq", as: "faq"
  get "hilfreiche-links", to: "links#index", as: "links"
  get "ueber-uns", to: "pages#about", as: "about"
  get "werbung" => "pages#werbung", as: "werbung"
  get "datenschutz" => "pages#datenschutz"
  get "impressum" => "pages#impressum"

  get "users/search", to: "users#search", as: :search_users

  resources :bundeslands, only: :show, path: "buerodienstleister-in-ihrem-bundesland"
  resources :offers, only: %i[show], path: "angebot"
  resources :users, only: %i[show], path: "ihr-partner"

  resources :users, only: [ :new, :create ], path: "visitenkarte-buchen", as: :users
  get "users/success" => "users#success", as: :success
  resources :blog_posts, only: %i[index show], path: "office-blogs"

  namespace :admin do
    root "dashboard#index"
    get "dashboard", to: "dashboard#index"

    resources :links, except: [ :show ]
    resources :tags, except: [ :show ]

    resources :users do
      member do
        delete :delete_image_attachment
      end
    end
    resources :blog_posts do
      member do
        patch :toggle_online
      end
    end
    resources :offers do
      member do
        patch :move_up
        patch :move_down
      end
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "up" => "rails/health#show", as: :rails_health_check
end
