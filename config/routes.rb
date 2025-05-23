Rails.application.routes.draw do
  root 'profile#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # Reveal health status on /up that returns 200 if the app boots with no exceptions,
  # otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
