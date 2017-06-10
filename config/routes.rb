Rails.application.routes.draw do

  resources :questions
  resources :advertisements
  resources :topics do
     resources :posts, except: [:index]
   end
  resources :sponsored_post
  resources :users, only: [:new, :create]
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root 'welcome#index'


 end
