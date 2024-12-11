class HomeController < ApplicationController
  def index
        # Ransack用の検索オブジェクトを生成
        @q = Room.ransack(params[:q])
  end
end
