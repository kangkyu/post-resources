PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, except: :destroy do
    post 'comments' => 'comments#create'
  end

  post 'categories' => 'categories#create'
  get 'categories/new', as: 'new_category'
end
