Rails.application.routes.draw do
  get 'home/top' => 'home#top'
  get 'users/new' => 'users#new'
  get 'users/login' => 'users#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
