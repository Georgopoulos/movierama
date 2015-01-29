Rails.application.routes.draw do
    
  # Static Pages
  root 'static_pages#home'


  # Users
  resources :users
  get 'signup'  => 'users#new'

  # Sessions
  get 'login'     => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # Movies
  resources :movies do
    # Votes
    resources :votes, only: [:create, :destroy]
  end
  
end
