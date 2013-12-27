Thirtysunshine::Application.routes.draw do

  get "search/index"

  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users
  
  resources :notifications, :only => [:index, :destroy] do
    collection do
      post :clear
    end
  end

  resources :nodes
  
  resources :topics do
    resources :comments
    resource :follow
  end

  match 'users/:id/topics' => 'users#topics', :as => :topics_user
  match 'users/:id/comments' => 'users#comments', :as => :comments_user
  match 'users/:id/follows' => 'users#follows', :as => :follows_user

  #match "/index" => "staticpages#index"
  match "/advice" => "staticpages#advice"
  match "/help" => "staticpages#help"

  get "/search" => "search#index"

  root :to => "topics#index"

 end
