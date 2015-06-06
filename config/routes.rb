PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  post 'categories' => 'categories#create'
  get 'categories/new', as: 'new_category'
  get 'category/:id' => 'categories#show', as: 'category'

  get 'login' => 'login#new'
  post 'login' => 'login#create'
  delete 'logout' => 'login#destroy'
  # resource :session

  get 'register' => 'users#new'

  resources :posts do
    # POST '/posts/:post_id/comments' => 'comments#create'
    resources :comments, only: [:create]
  end

  resources :users

  concern :votable do
    post 'vote', on: :member
  end
  # POST '/comments/:id/vote'
  resources :comments, only: [:vote], concerns: :votable
  # POST '/posts/:id/vote'
  resources :posts, only: [:vote], concerns: :votable

end
