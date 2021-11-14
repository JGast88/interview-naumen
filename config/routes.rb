Rails.application.routes.draw do
  get 'active_periods/create'
  get 'active_period/create'
  root to: 'people#index'
  resources :departments do
    member do
      get 'new_name'
      patch 'set_name'
      get 'new_parent'
      patch 'set_parent'
    end
  end
  resources :people
  resources :working_periods
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
