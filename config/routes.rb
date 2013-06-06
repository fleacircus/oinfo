Oinfo::Application.routes.draw do

	resources :dashboard, :only => :index
	resources :users do
  	get :autocomplete_mandator_name, :on => :collection
  end
  resources :mandators

	resource :account, :controller => "users", :only => :edit

  root :to => 'dashboard#index'

  devise_for :users,
		:path => '', :path_names => {
			:sign_in => 'login',
			:sign_out => 'logout'
		}

end
