Rails.application.routes.draw do

  resources :questions
  resources :advertisements
  resources :topics do
     resources :posts, except: [:index]
   end
  resources :sponsored_post
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root 'welcome#index'


 end
