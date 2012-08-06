Siesta::Application.routes.draw do

  # Student controllers
  devise_for :users, :controllers => { :sessions => "users/sessions" }

  resource :dashboard
  resource :profile, :only => [:show, :edit, :update] do
    get :state_list, :on => :member
  end

  resources :schoolings do
    get :show_document, :on => :member
  end
  resources :file_uploaders
  resources :user_requests do
    # Fixt it: It should be a collection
    get :remote_incharge_users, :on => :member
    get :form_dates, :on => :collection
  end
  resource :send_user_request
  ## Default controllers
  root :to => "dashboards#show"

  # Academic controllers
  namespace :academics do 
    resources :events
    resources :student_requests do
      get :update, :on => :member
      resources :events
    end
    resources :calendars
    resources :office_cubicles do
      resources :calendars
    end
    root :to => "student_requests#index"
    devise_for :users, :only => :sessions, :format => false
  end

  # Admin controllers
  namespace :managers do
    resources :students do
      get :card_back, :on => :member
      get :card_front, :on => :member
      get :authorize, :on => :member
      get :search, :on => :collection
    end
    resources :photos
    resources :emails
    resources :periods
    root :to => "students#index"
    devise_for :users, :only => :sessions, :format => false
  end

  namespace :librarians do
    resources :students 
    root :to => "students#index"
    devise_for :users, :only => :sessions, :format => false
  end
  
  namespace :public do
    resources :students
  end

  devise_for :accounts, :controllers => { :sessions => "accounts/sessions",
                                          :passwords => "accounts/passwords",
                                          :registrations => "accounts/registrations" }
end
