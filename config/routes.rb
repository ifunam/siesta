Siesta::Application.routes.draw do |map|
  # Authentication is not required for this controllers
  resource :session
  resource :recover_password
  resource :user

  # Student controllers
  resource :profile
  resource :dashboard
  resources :file_uploaders
  resources :schoolings do
  	member do
		get :show_document
	end
  end
  resources :user_requests
  resource :send_user_request

  # Academic controllers
  root :to => "sessions#new"
end
