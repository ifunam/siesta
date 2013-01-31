Siesta::Application.routes.draw do

  # Student controllers
  devise_for :users, :controllers => { :sessions => "users/sessions" }
  resource :profile, :only => [ :show, :edit, :update ]
  resources :schoolings
  resources :user_documents
  resources :user_requests
  resources :remote_users, :only => [ :index ]
  resources :disabilities, :only => [ :index ]
  # Default controllers
  root :to => "profiles#show"

  # Academic controllers
  namespace :academics do 
    # resources :events
    resources :student_requests, :only => [:index] do
      get :approve, :on => :member
      get :reject, :on => :member
    end
    #resources :calendars
    #resources :office_cubicles do
    #  resources :calendars
    #end
    root :to => "student_requests#index"
    devise_for :users, :only => :sessions, :format => false
  end

  # Admin controllers
  namespace :managers do
    resources :students do
      get :card_back, :on => :member
      get :card_front, :on => :member
      get :authorize, :on => :member
      get :destroy_request, :on => :member
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
