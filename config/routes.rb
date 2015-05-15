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

  resources :posts, except: :destroy do
    # post 'comments' => 'comments#create'
    resources :comments, only: [:create, :vote] do
      member do
        post 'vote'
      end
    end
    # post 'posts/:id/comments/:id/vote'
    # resources :votes  # POST 'posts/:post_id/votes'
    member do
      post 'vote'       # POST 'posts/:id/vote'
    end
  end

  resources :users
end
