Rails.application.routes.draw do
  resources :departments
  resources :people
  resources :working_periods
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
