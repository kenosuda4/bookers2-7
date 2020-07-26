Rails.application.routes.draw do

  root 'homes#top'
  get 'home/about', to: 'homes#about'
  devise_for :users
 
   resources :users, only:[:index, :show, :edit, :update, :index] do #フォロー・フォロワー一覧に移動するための記述が足りなかった　do以降
    member do        #ここから
     get :following, :followers
    end
  end               #ここまで
  resources :relationships, only: [:create, :destroy]


  resources :books do
    #resource :favorites, only: [:create, :destroy]
    post 'add' => 'favorites#create'
    delete '/add' => 'favorites#destroy'
    resource :book_comments, only: [:create, :destroy]
  end
  
  #get '/search' => 'search#search'
  #get '/search', to: 'search#search'
  #↓=> 'search#searchをsearchs#search'に変更
  get '/search' => 'searchs#search', as: 'search' 
 



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
