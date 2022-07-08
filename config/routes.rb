Rails.application.routes.draw do
  # get 'welcome/index', to: 'welcome#index'
  root 'welcome#index'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'

  get 'logout', to: 'sessions#destroy'

  get 'password', to: 'passwords#edit', as: 'edit_password'
  patch 'password', to: 'passwords#update'

  # get 'password/reset', to: 'password_resets#new'
  # post 'password/reset', to: 'password_resets#create'

  # get 'password/reset/edit', to: 'password_resets#edit'
  # patch 'password/reset/edit', to: 'password_resets#update'

  get 'admin', to: 'admin/dashboard#index'
  get 'admin/change_price', to: 'admin/dashboard#change_price', as: 'change_price'
  post 'admin/change_price', to: 'admin/dashboard#update_price', as: 'update_price'

  get 'beerme', to: 'beerme#index'
end
