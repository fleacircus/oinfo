Oinfo::Application.routes.draw do

  resources :dashboard, :only => :index

  resources :testing, :only => [:index]
  get '/testing/generate_message'

  resources :users do
    get :autocomplete_mandator_name, :on => :collection
  end

  namespace :accounting do
    resources :customers
    resources :distributors
    resources :invoices
  end

  resources :mandators
  resources :messages

  resource :account, :controller => 'users', :only => :edit

  root :to => 'dashboard#index'

  devise_for :users,
    :path => '', :path_names => {
      :sign_in => 'login',
      :sign_out => 'logout'
    }

  resources :changes, :controller => 'changes', :only => [:index, :show, :update]
  match '/changes/:item_type/:item_id' => 'changes#index',
    :as => 'instance_changes', :via => :get, :controller => 'changes',
    :constraints => {:item_id => /\d+/}

  match '/files/:id/:basename.:extension', :controller => 'attachments',
    :action => 'download', :conditions => { :method => :get }

end
