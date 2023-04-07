Rails.application.routes.draw do
  root to: "events#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: %i[index show]
  resources :events do
    resource :enrollments, only: %i[create destroy], module: :events
  end
end
