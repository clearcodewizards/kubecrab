Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  mount MissionControl::Jobs::Engine, at: "/admin/jobs"

  get "up" => "rails/health#show", as: :rails_health_check

  root "crabs#index"

  resources :crabs do
    member do
      get "restart"
      get "upgrade"
    end
  end

  resource :profile, only: %i[show update destroy], controller: :profile
  resources :templates, only: %i[index]

  namespace :admin do
    resources :templates do
      resources :options, controller: :template_options
    end
    resources :engines
    resources :users
  end
end
