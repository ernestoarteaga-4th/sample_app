SampleApp::Application.routes.draw do
  
  get "email/remind"
  
  post "email/remind"

  resources :users do
    member do
      get :following, :followers, :change
      post :change
    end
    collection do
      get 'search'
    end 
  end
 
  resources :pages do
    collection do
      get 'search'
    end
  end
  
  resources :users
  resources :sessions,   :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :followings, :only => [:create, :destroy]

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/home',    :to => 'pages#home'

  root :to => 'pages#home'
end
