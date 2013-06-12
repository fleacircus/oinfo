Oinfo::Application.routes.draw do

	resources :dashboard, :only => :index

	resources :users do
  	get :autocomplete_mandator_name, :on => :collection
  end

  resources :mandators

  resources :messages

	resource :account, :controller => "users", :only => :edit

  root :to => 'dashboard#index'

  devise_for :users,
		:path => '', :path_names => {
			:sign_in => 'login',
			:sign_out => 'logout'
		}

	resources :changes, :controller => 'changes'
	match "/changes/:item_type/:item_id" => "changes#index",
	  :as => "model_changes", :via => :get, :controller => 'changes',
	  :constraints => {:item_id => /\d+/}

end
