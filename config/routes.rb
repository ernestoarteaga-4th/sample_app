SampleApp::Application.routes.draw do

  get "email/remind"

  post "email/remind"

  resources :candidates do
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

  resources :candidates

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

  match "/candidates/:id/resume" => 'resume#index'
  match "/candidates/:id/resume/photo" => 'resume#photo'
  match "/candidates/:id/resume/summary" => 'resume#summary'
  match "/candidates/:id/resume/experience" => 'resume#experience'
  match "/candidates/:id/resume/experience/new" => 'experiences#new'
  match "/candidates/:id/resume/experience/:experience_id/skills/new" => 'experiences#skill'
  match "/experiences/:id/destroy" => 'experiences#destroy'
  match "/candidates/:id/resume/experience/:experience_id/details/new" => 'experience_details#new'
  match "/resume_details/:id/destroy" => 'resume_details#destroy'
#  match "/candidates/:id/resume/education" => 'resume#education'
#  match "/education/destroy" => 'educations#destroy'
  # Projects
  match "/candidates/:id/resume/projects" => 'project#index'
  match "/candidates/:id/resume/projects/new" => 'project#new'
  match "/project/:id/destroy" => 'project#destroy'
  ## Project Roles
  match "/candidates/:id/resume/:project_id/project-roles/new" => 'project_role#new'
  match "/candidates/:id/resume/:project_id/project-roles/edit" => 'project_role#edit'
  match "/project-roles/:id/destroy" => 'project_role#destroy'
  ### Tools
  match "/candidates/:id/resume/:project_id/project-roles/:project_role_id/tools/new" => 'project_tool_tag#new'
  match "/tools/:id/destroy" => 'project_tool_tag#destroy'
  match "/tools/:id/remove" => 'project_tool_tag#remove'
  match "/project/:project_id/project-roles/:project_role_id/tool/add" => 'project_tool_tag#add'
  ### Technologies
  match "/candidates/:id/resume/:project_id/project-roles/:project_role_id/tech/new" => 'project_technology_tag#new'
  match "/tech/:id/destroy" => 'project_technology_tag#destroy'
  match "/tech/:id/remove" => 'project_technology_tag#remove'
  match "/project/:project_id/project-roles/:project_role_id/technology/add" => 'project_technology_tag#add'
  ### Knowledges
  match "/candidates/:id/resume/:project_id/project-roles/:project_role_id/knowledge/new" => 'project_knowledge_tag#new'
  match "/knowledge/:id/destroy" => 'project_knowledge_tag#destroy'
  match "/knowledge/:id/remove" => 'project_knowledge_tag#remove'
  match "/project/:project_id/project-roles/:project_role_id/knowledge/add" => 'project_knowledge_tag#add'
  ### Responsabilities
  match "/candidates/:id/resume/:project_id/project-roles/:project_role_id/responsibility/new" => 'project_responsibility_tag#new'
  match "/responsibility/:id/destroy" => 'project_responsibility_tag#destroy'
  match "/responsibility/:id/remove" => 'project_responsibility_tag#remove'
  match "/project/:project_id/project-roles/:project_role_id/responsibility/add" => 'project_responsibility_tag#add'
  # Education
  match "/candidates/:id/resume/education" => 'resume_education#index'
  match "/candidates/:id/resume/education/new" => 'resume_education#new'
  match "/education/destroy" => 'resume_education#destroy'
  # Certification
  match "/candidates/:id/resume/certification" => 'resume_certification#index'
  match "/candidates/:id/resume/certification/new" => 'resume_certification#new'
  match "/certification/destroy" => 'resume_certification#destroy'
  # Trainings
  match "/candidates/:id/resume/training" => 'resume_training#index'
  match "/candidates/:id/resume/training/new" => 'resume_training#new'
  match "/training/destroy" => 'resume_training#destroy'
  # Languages
  match "/candidates/:id/resume/languages" => 'resume_language#index'
  match "/candidates/:id/resume/languages/new" => 'resume_language#new'
  match "/languages/destroy" => 'resume_language#destroy'

  # Autocomplete
  match "/tool/autocomplete" => 'tool_tag#autocomplete'
  match "/tech/autocomplete" => 'technology_tag#autocomplete'
  match "/know/autocomplete" => 'knowledge_tag#autocomplete'

  match '/skills', :to => 'skills#index'
  match '/skills/new', :to => 'skills#new'


  root :to => 'pages#home'
end
