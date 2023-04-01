Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"

  resources :projects, only: %i[index show new create edit update]
  resources :project_changes, only: %i[create]
end
