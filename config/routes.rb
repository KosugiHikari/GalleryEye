Rails.application.routes.draw do
  
  # ユーザー側（コントローラーの記述を変更してもその処理が実行されるようにするため）
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # ユーザー側のルーティング設定
  scope module: :public do
    
    #homes
    root to: 'homes#top'
    get '/about' => 'homes#about'
    
    #users
    resources :user, only: [:index, :edit, :show, :update]
    get '/user/leavecheck' => 'users#leave_check' #退会確認
    patch '/user/leave' => 'users#leave' #退会
    
    #posts
    resources :post, only: [:index, :show, :create, :edit, :update, :destroy]
    
  end
  
  
  # 管理者側（コントローラーの記述を変更してもその処理が実行されるようにするため）
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  
  # 管理者側のルーティング設定
  namespace :admin do
    
    #users
    resources :user, only: [:index, :edit, :show, :update]
    
    #posts
    resources :post, only: [:index, :show, :edit, :update, :destroy]
    
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
