Rails.application.routes.draw do

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