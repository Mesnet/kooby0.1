Rails.application.routes.draw do

  #Repository
  patch "show_repository" => "contacts#show_sn"
  patch "show_contacts" => "contacts#show"
  patch "show_groups" => "groups#show"
  patch "show_companies" => "companies#show"

  #Project
  resources :projects do 
    member do
      # For Params
      patch :open_params
      patch :quit
      patch :expel
      patch :upd_role
      patch :fav
      patch :mute
      patch :unfav
      patch :unmute
      # For each features
      get :taskboard
      get :calendar
      get :cloud
    end
  end

  resources :email_projects

  #User
  devise_for :users
  resources :user_infos

  #Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # ROOT
  authenticated :user do
    root to: "pages#home", as: :authenticated_root
  end
  unauthenticated do
    root 'pages#landing'
  end

  #Test Page
  get "test" => "pages#test"

end