Rails.application.routes.draw do
  
  root 'users#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  resources :users, except: [:new, :edit, :update, :create] do
    member do
      get 'matches'
    end
  end

  resources :rooms, only: [:index] do
    resources :messages, only: [:create]
  end

  delete '/attachments/:id/purge', to: 'attachments#purge' , as: 'purge_attachments'
  delete '/dislike/:liker_id/:likee_id', to: 'likes#destroy', as: 'destroy_like'
  post '/like', to: 'likes#create', as: 'create_like'
end
