Bloccit::Application.routes.draw do

  get "comments/create"

  devise_for :users
  resources  :users, only: [ :update ]

  resources :topics do
    resources :posts, except: [ :index ]
  end

  resources :posts, only: [] do
    resources :comments, only: [ :create, :destroy ]
  end
    
  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
