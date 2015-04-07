PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, except: :destroy do
    post 'comments' => 'comments#create'
  end

  post 'categories' => 'categories#create'
  get 'categories/new', as: 'new_category'
  get 'category/:id' => 'categories#show', as: 'category'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  # resource :session

  resources :users
end
