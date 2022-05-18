Rails.application.routes.draw do
  root 'users#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  resources :users
 
end
