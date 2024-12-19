Rails.application.routes.draw do
  # トップページ
  root "home#index"

  # Deviseによるユーザー認証
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # ユーザー関連のリソース
  resources :users, only: [:index, :show] do
    member do
      get :edit_profile  # プロフィール編集ページ
      patch :update_profile # プロフィール更新処理
    end
  end

  # Roomsリソース
  resources :rooms do
    collection do
      get :my_rooms # 登録済み施設一覧のルート
    end
    resources :reservations, only: [:new, :create]
  end

  resources :rooms do
    resources :reservations, only: [:new, :create, :show] do
      member do
        get :confirmation # 確認画面へのルート
        patch :confirm     # 確定処理
      end
    end
  end

  # Reservationsリソース
  resources :reservations, only: [:index, :show, :destroy] do
    member do
      patch :confirm  # 予約確定のルート
    end
  end
end
