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
  resources :resume

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/home',    :to => 'pages#home'
  
  match "/users/:id/resume" => 'resume#index'
  match "/users/:id/resume/photo" => 'resume#photo'
  match "/users/:id/resume/summary" => 'resume#summary'
  match "/users/:id/resume/experience" => 'resume#experience'
  match "/users/:id/resume/experience/new" => 'experiences#new'
  match "/users/:id/resume/experience/:experience_id/skills/new" => 'experiences#skill'
  match "/experiences/:id/destroy" => 'experiences#destroy'
  match "/users/:id/resume/experience/:experience_id/details/new" => 'experience_details#new'
  match "/users/:id/resume/idioms" => 'idioms#index'
  match "/idioms/new" => 'idioms#new'
  match "/idioms/destroy" => 'idioms#destroy'
  
  match "/experience_details/:id/destroy" => 'experience_details#destroy'
  
  match '/skills', :to => 'skills#index'
  match '/skills/new', :to => 'skills#new'
  
   
  root :to => 'pages#home'
end
