class UsersController < ApplicationController
  before_action :authenticate_user!  # ログインしていることを確認
  before_action :set_user, only: [:edit_account, :edit_profile, :update_profile]

  # プロフィール編集画面
  def edit_profile
  end

  # プロフィール更新処理
  def update_profile
    if @user.update(user_params)
      redirect_to root_path, notice: 'プロフィールを更新しました。'
    else
      render :edit_profile
    end
  end

  def index
    # 必要な処理を記述する
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :icon) # 必要なフィールドを追加
  end

  def set_user
    @user = current_user
  end


end

