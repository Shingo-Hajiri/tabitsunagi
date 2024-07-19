Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
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

  resources :plans, only: %i[index new create edit show update destroy] do
    collection do
      get :complete
      get :my_recommends
    end
  end

  resource :profile, only: %i[edit show update destroy]

  # Defines the root path route ("/")
  # root "posts#index"
end
