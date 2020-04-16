Rails.application.routes.draw do

  
  post  'users/:id/update'  => 'users#update'
  get   'users/:id/edit'    => 'users#edit'
  post  'users/create'      => 'users#create'
  get   'users/new'         => 'users#new'
  get   'users/index'       => 'users#index'
  
  post  'users/login'       => 'users#login'
  post  'users/logout'      => 'users#logout'
  get   'users/login'       => 'users#login_form'
  get   'users/:id'         => 'users#show'
  get   'users/:id/likes'   => 'users#likes'

  get   "users/:id/following" => "users#following"


  
  

  get   'posts/index'       => 'posts#index'
  get   'posts/new'         => 'posts#new'
  post  'posts/create'      => 'posts#create'
  get   'posts/:id'         => 'posts#show'
  get   'posts/:id/edit'    => 'posts#edit'
  post  'posts/:id/update'  => 'posts#update'
  post  'posts/:id/destroy' => 'posts#destroy'

  post  'likes/:post_id/create' => 'likes#create'
  post  'likes/:post_id/destroy'=> 'likes#destroy'

  get   '/'                 => 'posts#index'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :following, :followers
    end
  end


  resources :relationships,       only: [:create, :destroy]


end
