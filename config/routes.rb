Rails.application.routes.draw do
  # get 'welcome/index', to: 'welcome#index'
  root 'welcome#index'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  get 'verify_phone', to: 'registrations#verify_phone'
  post 'verify_phone', to: 'registrations#post_verify'

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
  get 'admin/users/:user_id', to: 'admin/user#show', as: 'user_page'
  patch 'admin/users/:user_id', to: 'admin/user#update_user', as: 'update_user'
  delete 'admin/users/:user_id', to: 'admin/user#delete_user', as: 'delete_user'
  get 'admin/payments/:user_id', to: 'admin/user#payment_page', as: 'payment_page'
  post 'admin/payments/:user_id', to: 'admin/user#apply_payment', as: 'apply_payment'

  get 'beerme', to: 'beerme#index'
  post 'beerme', to: 'beerme#beerme', as: 'beer_me'
end
