Rails.application.routes.draw do
  namespace :public do
    get 'bags/index'
  end
  #namespace :admin do
    #get 'comments/form'
    #get 'comments/index'
  #end
  root to: 'homes#top'

  devise_for :customers, module: 'public', skip: [:passwords], contollers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, module: 'admin', skip: [:registrations, :passwords], contllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    # Adminのルーティングを記述する
    resources :customers, only: [:index, :show, :edit, :update]
    resources :recipes, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

  scope module: :public do
    # public配下はすべてここで処理させる
    # カスタマーのルーティングを記述する
    # ref: https://qiita.com/ryosuketter/items/9240d8c2561b5989f049#module--controller
    get 'customers/confirm' => 'customers#confirm'#退会確認画面
    patch 'customers/withdraw' => 'customers#withdraw'#削除
    resources :bags, only: [:index]
    resources :customers, only: [:show, :edit, :update]
    resources :recipes do
      # コメント機能を付ける場合、public/comments_conteollerを作り以下を使う
      resources :comments, only: [:create, :destroy]
      collection do # ref: https://qiita.com/hirokihello/items/fa82863ab10a3052d2ff
        get 'favorites' => 'favorites#index'
      end
      resource :favorites, only: [:create, :destroy] # indexが作られないので、上で定義している
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
