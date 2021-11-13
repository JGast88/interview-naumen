Rails.application.routes.draw do
  root to: 'people#index'
  resources :departments do
    member do
      get 'change_name'
      patch 'change_name'
    end
  end

  
  resources :people
  resources :working_periods
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
