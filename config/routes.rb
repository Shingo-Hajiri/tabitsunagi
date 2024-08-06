Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'sign_up'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "tops#top"

  get 'edit_last_plan', to: 'plans#edit_last', as: :edit_last_plan
  get 'usage', to: 'static_pages#usage'
  get 'inquiry', to: 'static_pages#inquiry'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'

  resources :plans, only: %i[index new create edit show update destroy] do
    collection do
      get :complete
      get :my_recommends
      get :spots_map
    end
  end

  resource :profile, only: %i[edit show update destroy] do
    member do
      get :email_edit
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Defines the root path route ("/")
  # root "posts#index"
end
