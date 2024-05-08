Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'
  get '/dashboard', to: 'home#dashboard', as: 'dashboard'

  namespace :admin do
    root 'dashboard#index' # Admin dashboard root path
    resources :users, only: %i[index show update destroy]
    resources :themes, only: %i[index edit update destroy]
  end

  resources :resumes do
    resources :experiences
    resources :educations
    resources :skills, only: %i[new create destroy]
    resource :social_link, only: %i[new create edit update destroy]
    resource :cover_letter, only: %i[new create edit update destroy]
    resource :theme, only: %i[edit update] # Added for theme management ui
    member do
      get 'download_pdf'
    end
  end
end
