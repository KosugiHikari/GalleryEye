Rails.application.routes.draw do

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end

  # ユーザー側（コントローラーの記述を変更してもその処理が実行されるようにするため）
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # ユーザー側のルーティング
  scope module: :public do

    root to: 'posts#index'

    #homes
    get '/about' => 'homes#about'

    #users
    resources :users, only: [:index, :edit, :show, :update, :leave_check] do
      member do
        get :likes
        get :confirm
      end
      resource :relationships, only: [:create, :destroy]
      get '/:id/followings' => 'relationships#followings', as: 'followings'
      get '/:id/followers' => 'relationships#followers', as: 'followers'
    end

    get '/users/:id/leavecheck' => 'users#leave_check', as: 'leavecheck' #退会確認
    patch '/users/:id/leave' => 'users#leave', as: 'leave' #退会

    #posts
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    # tags
    resources :tags

    # searches
    get 'search' => 'searches#search'

  end


  # 管理者側（コントローラーの記述を変更してもその処理が実行されるようにするため）
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  # 管理者側のルーティング
  namespace :admin do

    root to: 'users#index'

    # ユーザーごとの投稿のルーティング
    get 'users/:user_id/posts' => 'posts#index', as: 'user_posts'

    #users
    resources :users, only: [:index, :edit, :show, :update]

    #posts
    resources :posts, only: [:index, :show, :edit, :update, :destroy]

    # searches
    get 'search' => 'searches#search'

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
