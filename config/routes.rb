Siesta::Application.routes.draw do |map|

  # Student controllers
  devise_for :users, :format => false
  resource :dashboard
  resource :profile do
    get :person_state_list, :on => :member
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

  devise_for :accounts, :controllers => { :sessions => "accounts/sessions",
                                          :registrations => "accounts/registrations" },
                                          :format => false
  namespace :accounts do
    root :to => "dashboards#show"
  end

  # Academic controllers
  namespace :academics do 
    resources :student_requests do
      get :update, :on => :member
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
    end
    resources :photos
    resources :emails
    root :to => "students#index"
    devise_for :users, :only => :sessions, :format => false
  end

  namespace :public do
    resources :students
  end
end
