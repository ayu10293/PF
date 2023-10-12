Rails.application.routes.draw do
  root to:'homes#top'
  devise_for :customers, module: 'public', skip: [:passwords], contollers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admins,skip: [:registrations, :passwords], contllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    # Adminのルーティングを記述する
  end

  scope module: :public do
    # カスタマーのルーティングを記述する
    # ref: https://qiita.com/ryosuketter/items/9240d8c2561b5989f049#module--controller
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
