class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  
    # 施設一覧 Ransackでの検索処理
    def index
      @q = Room.ransack(params[:q])
      @rooms = @q.result(distinct: true)

    # エリア検索処理
    if params[:area].present?
      @rooms = @rooms.where(address: params[:area])
    end

      @total_rooms = @rooms.count
    end
  
    # 施設詳細
    def show
    end
  
    # 新規作成フォーム
    def new
      @room = Room.new
    end

    # 自分が登録した施設一覧を表示
    def my_rooms
      @rooms = current_user.rooms
    end
  
    # 作成処理
    def create
      @room = current_user.rooms.new(room_params) # current_user.roomsを使ってユーザーを関連付け

      if @room.save
        redirect_to @room, notice: "施設が作成されました。"
      else
        flash.now[:alert] = "登録に失敗しました。入力内容を確認してください。"
        render :new
      end
    end

    # 削除処理
    def destroy
      @room.destroy
      redirect_to rooms_path, notice: "施設を削除しました。"
    end
  
    private
  
    def set_room
      @room = Room.find(params[:id])
    end
  
    def room_params
      params.require(:room).permit(:name, :description, :price, :address, :image_url)
    end
  end
  