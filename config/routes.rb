Rails.application.routes.draw do
  root 'pages#home'

  resources :posts do
    member do
      get 'toggle_follow', to: 'posts#toggle_follow'
      get 'toggle_like', to: 'posts#toggle_like'

    end
    collection do
      get 'feed'
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
