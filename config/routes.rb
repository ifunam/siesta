Siesta::Application.routes.draw do |map|
  devise_for :users
  devise_for :accounts, :controllers => { :sessions => "accounts/sessions" }
  devise_for :managers
  devise_for :academics

  ## Student controllers
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

  ## Academic controllers
  namespace :academics do 
    resources :student_requests do
      member do 
        get :update
      end
    end
  end

  # Admin controllers
  namespace :managers do 
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
  ## Default controllers
  root :to => "dashboards#show"
end
