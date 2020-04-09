Rails.application.routes.draw do
  get 'posts/index' => 'posts/index'
  get 'home/top'    => 'home#top'
  get 'users/new'   => 'users#new'
  get 'users/login' => 'users#login'
  get 'posts/index' => 'posts#index'
  get 'posts/new'   => 'posts#new'
  post 'posts/create' => 'posts#create'
  get 'posts/:id'   => 'posts#show'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update'  => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
