Siesta::Application.routes.draw do |map|
  # Authentication is not required for this controllers
  resource :session
  match '/logout', :to => "sessions#destroy", :as => 'logout'

  resource :recover_password
  resource :user

  # Student controllers
  resource :profile 
  get "/profile/person_state_list/:id", :to => "profiles#person_state_list"
  resource :dashboard
  resources :file_uploaders
  resources :schoolings do
    member do
      get :show_document
    end
  end
  resources :user_requests do
    # Fixt it: It should be a collection
    member do 
      get :remote_incharge_users
    end
    collection do
      get :form_dates
    end
  end
  resource :send_user_request

  # Academic controllers
  namespace :academic do 
    resource :session
    resources :student_requests do
      member do 
        get :update
      end
    end
    match 'logout', :to => "academic/sessions#destroy", :as => 'logout'
  end

  # Admin controllers
  namespace :admin do 
    resource :session
    match 'logout', :to => "admin/sessions#destroy", :as => 'logout'
    resources :students do
      member do
        get :card_back
        get :card_front
      end
    end
    resources :photos
    resources :emails
  end

  namespace :public do
    resources :students
  end
  # Default controllers
  root :to => "sessions#new"
end
