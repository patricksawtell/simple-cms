Rails.application.routes.draw do

  root 'public#index'

  get 'show/:permalink', :to => 'public#show', :as => 'public_show'

  get 'admin', :to => 'access#menu'
  #simple match-route for access (doesn't have db table or model)
  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

	#resourceful routes 
  resources :subjects do
    member do
      get :delete 
    end
  end


  resources :pages do
    member do
      get :delete 
    end
  end

  resources :sections do
    member do
      get :delete 
    end
  end

  resources :admin_users, :except => [:show] do
    member do
      get :delete 
    end
  end
  
  get 'demo/index'
  get 'demo/hello'
  get 'demo/other_hello'
  get 'demo/google'
  get 'demo/escape_output'
	get 'test/index'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
