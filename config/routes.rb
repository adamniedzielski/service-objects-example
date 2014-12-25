Rails.application.routes.draw do
  resources :comments, only: [:new, :create, :index]
  root 'comments#index'
end
