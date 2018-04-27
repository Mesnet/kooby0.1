Rails.application.routes.draw do

  #Contacts
  resources :contacts
  patch "show_contacts" => "contacts#show_sn"

  #Project
  resources :projects do 
    member do
      patch :open_params
      patch :quit
      patch :expel
      patch :upd_role
      patch :fav
      patch :mute
      patch :unfav
      patch :unmute
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