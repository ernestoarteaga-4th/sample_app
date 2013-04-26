SampleApp::Application.routes.draw do  

  resources :candidates_profiles


  get "email/remind"

  post "email/remind"

  resources :candidates do
    member do
      get :following, :followers, :change, :index
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

  resources :candidates do
    resources :candidate_certifications
    resources :candidate_profiles
    resources :candidate_profile_tags
  end

  resources :sessions,   :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  
  resources :followings do
    collection do 
       post  'follow'
    end
  end

  resources :resume
  resources :candidate_prof_summaries do
    collection do
      get 'destroy'
      post 'destroy'
    end
  end

  resources :candidate_certifications do
    collection do
      get 'destroy'
      post 'destroy'
    end
  end

  match '/signup',  :to => 'candidates#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/home',    :to => 'pages#home'

  match "/candidates/:id/resume" => 'resume#index'
  match "/candidates/:id/resume/staff_update" => 'resume#staff_update'
  match "/candidates/:id/resume/summary" => 'resume#summary'
  match "/candidates/:id/resume/experience" => 'resume#experience'
  match "/candidates/:id/resume/experience/new" => 'experiences#new'
  match "/candidates/:id/resume/experience/:experience_id/skills/new" => 'experiences#skill'
  match "/experiences/:id/destroy" => 'experiences#destroy'
  match "/candidates/:id/resume/experience/:experience_id/details/new" => 'experience_details#new'
  #match "/resume_details/:id/destro" => 'resume_details#destro'
  match "/candidate_prof_summaries/destro" => 'candidate_prof_summaries#destro'
  #match "/resume_details/:id/destroy" => resume_details_destroy_path
#  match "/candidates/:id/resume/education" => 'resume#education'
#  match "/education/destroy" => 'educations#destroy'
  # Projects
  match "/candidates/:id/projects" => 'projects#index'
  match "/candidates/:id/projects/new" => 'projects#new'
  match "/candidates/:id/project/:project_id/update" => 'projects#update'
  match "/candidates/:id/project/:project_id/show" => 'projects#show'
  match "/candidates/:id/project/:project_id/destroy" => 'projects#destroy'
  ## Project Roles
  match "/candidates/:id/project/:project_id/projects_roles/new" => 'projects_roles#new'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/update" => 'projects_roles#update'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/show" => 'projects_roles#show'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/destroy" => 'projects_roles#destroy'
  ## Project Responsibilities
  match "/candidates/:id/projects/:project_id/projects_roles/:projects_role_id/roles_responsibilities/new" => 'roles_responsibilities#new'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/roles_responsibilities/:rolerespon_id/destroy" => 'roles_responsibilities#destroy'
  ## Project Tags
  match "/candidates/:id/projects/:project_id/projects_roles/:projects_role_id/projects_tags/:type_id/new" => 'projects_tags#new'
  match "/candidates/:id/project/:project_id/projects_role/:projects_role_id/projects_tags/:projtag_id/destroy" => 'projects_tags#destroy'
  # Education
  match "/education/:id" => 'education#index', :as => :candidate_education
  match "/education/destroy" => 'candidate_education#destroy'
  match "/candidates/:id/resume/education" => 'candidate_education#index'
  match "/candidates/:id/resume/education/new" => 'candidate_education#new'
  match "/candidates/:id/resume/education/create" => 'candidate_education#create', :as => :candidate_education_index
  match "/candidates/:id/resume/education/edit" => 'candidate_education#edit'
  match "/candidates/:id/resume/education/update" => 'candidate_education#update'
  match "/candidates/:id/resume/education/destroy" => 'candidate_education#destroy'
  match "/candidates/:id/education_degree" => 'educ_degree#index'
  match "/candidates/:id/education_degree/new" => 'educ_degree#new'
  match "/candidates/:id/education_degree/create" => 'educ_degree#create'
  match "/candidates/:id/education_degree/edit" => 'educ_degree#edit'
  match "/candidates/:id/education_degree/update" => 'educ_degree#update'
  match "/candidates/:id/education_degree/destroy" => 'educ_degree#destroy'
  match "/candidates/:id/education_degree/action" => 'educ_degree#action'

  # Candidate
  match "/staff/:id/candidates" => 'staff_candidates#index'
  match "/staff/:id/candidates/detail" => 'staff_candidates#search'

  # Candidate Status
  match "/staff/:id/candidate_status" => 'status#index'
  match "/staff/:id/candidate_status/create" => 'status#create'
  match "/staff/:id/candidate_status/destroy" => 'status#destroy'

  # Interviewers
  match "/staff/:id/interviewers" => 'interviewers#index'
  match "/staff/:id/interviewers/new" => 'interviewers#new'
  match "/staff/:id/interviewers/:interviewer_id/edit" => 'interviewers#edit'
  match "/staff/:id/interviewers/:interviewer_id/delete" => 'interviewers#delete'
    
  # Candidate Certification
  #match "/candidates/:id/resume/certification" => 'candidate_certification#index'
  #match "/candidates/:id/resume/certification/new" => 'candidate_certification#new'
  match "/candidate_certifications/destro" => 'candidate_certifications#destro'
  #match "/resume_details/destro" => 'resume_details#destro'
  
  # Certifications
  match "/staff/:id/certifications" => 'certifications#index'
  match "/staff/:id/certifications/action" => 'certifications#action'
  match "/staff/:id/certifications/new" => 'certifications#new'
  match "/staff/:id/certifications/:certification_id/edit" => 'certifications#edit'
  match "/staff/:id/certifications/:certification_id/delete" => 'certifications#delete'
  
  # Roles
  match "/staff/:id/roles" => 'roles#index'
  match "/staff/:id/roles/action" => 'roles#action'
  match "/staff/:id/roles/new" => 'roles#new'
  match "/staff/:id/roles/:role_id/edit" => 'roles#edit'
  match "/staff/:id/roles/:role_id/delete" => 'roles#delete'
  
  # Trainings
  match "/candidates/:id/resume/training" => 'candidate_training#index'
  match "/candidates/resume/training/new" => 'candidate_training#new'
  match "/training/destroy" => 'candidate_training#destroy'
  # Languages
  match "/candidates/:id/resume/languages" => 'candidate_languages#index'
  match "/candidates/resume/languages/new" => 'candidate_languages#new'
  match "/languages/destroy" => 'candidate_languages#destroy'
  match "/staff/:id/languages" => 'languages#index'
  match "/staff/:id/languages/new" => 'languages#new'
  match "/staff/:id/languages/create" => 'languages#create'
  match "/staff/:id/languages/action" => 'languages#action'

  # Tags
  match "/staff/:id/tags" => 'tags#index'
  match "/staff/:id/tags/new" => 'tags#new'
  match "/staff/:id/tags/create" => 'tags#create'
  match "/staff/:id/tags/edit" => 'tags#edit'
  match "/staff/:id/tags/update" => 'tags#update'
  match "/staff/:id/tags/destroy" => 'tags#destroy'
  match "/staff/:id/tags/action" => 'tags#action'

  # Report
  match "/staff/:id/report" => 'report#index'
  match "/staff/:id/report/search" => 'report#search'

  # Autocomplete
  match "/tool/autocomplete" => 'tool_tag#autocomplete'
  match "/tech/autocomplete" => 'technology_tag#autocomplete'
  match "/know/autocomplete" => 'knowledge_tag#autocomplete'

  match '/skills', :to => 'skills#index'
  match '/skills/new', :to => 'skills#new'
  
  # Candidates Interviews
  match "/candidates/:id/candidates_interviews" => 'candidates_interviews#index'
  match "/candidates/:id/candidates_interviews/:cand_inter_id/edit" => 'candidates_interviews#edit'
  match "/candidates/:id/candidates_interviews/new" => 'candidates_interviews#new'
  match "/candidates/:id/candidates_interviews/:cand_inter_id/delete" => 'candidates_interviews#delete'
  ## Interviews Type
  match "/staff/:id/interviews_types" => 'interviews_types#index'
  match "/staff/:id/interviews_types/new" => 'interviews_types#new'
  match "/staff/:id/interviews_types/:interview_type_id/edit" => 'interviews_types#edit'
  match "/staff/:id/interviews_types/:interview_type_id/delete" => 'interviews_types#delete'
  
  ## Candidates Profiles
  match "/candidates/:candidate_id/candidate_profiles" => 'candidate_profiles#index'
  match "/candidates/:candidate_id/candidate_profiles/:candidate_profile_id/delete" => 'candidate_profiles#delete'
  match "/candidates/:candidate_id/candidate_profiles/:candidate_profile_id/edit" => 'candidate_profiles#edit'
  match "/candidates/:candidate_id/candidate_profiles/:candidate_profile_id/update" => 'candidate_profiles#update'
  match "/candidates/candidate_profiles/:id/update_tags" => 'candidate_profiles#update_tags'

  root :to => 'pages#home'
end
