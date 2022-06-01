Rails.application.routes.draw do
  root 'users#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  resources :users
  delete "attachments/:id/purge", to: "attachments#purge" , as: "purge_attachments"

  post 'likes/index', to: 'likes#create', as: 'create_like'
  get 'likes/index', to: 'likes#index', as: 'index_likes'
end
