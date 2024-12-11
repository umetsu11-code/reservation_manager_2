Rails.application.routes.draw do
  # トップページ
  root "home#index"

  # Deviseによるユーザー認証
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:index, :show] # 追加: indexアクションを含むリソース定義
  # Roomsリソース
  resources :rooms do
    collection do
      get :my_rooms # 登録済み施設一覧のルート
    end
    resources :reservations, only: [:new, :create, :index]
  end
  #予約確定画面
  resources :reservations, only: [:index, :show, :destroy] do
    member do
      patch :confirm  # 予約確定のルート
    end
  end

  # Reservationsリソース
  resources :reservations, only: [:index, :show, :destroy]

  # プロフィール編集ページ用のルート
  resources :users, only: [] do
    member do
      get :edit_profile  # プロフィール編集ページ
      patch :update_profile # プロフィール更新処理
    end
  end
end