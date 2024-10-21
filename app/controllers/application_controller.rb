class ApplicationController < ActionController::Base
    # ユーザーが認証されているかを確認する
    before_action :authenticate_user!
  end
