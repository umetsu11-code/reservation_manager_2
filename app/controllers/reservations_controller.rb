class ReservationsController < ApplicationController
    before_action :set_room, only: [:new, :create]
    before_action :set_reservation, only: [:show, :destroy, :confirm]
    before_action :authenticate_user!

    # 予約一覧
    def index
      @reservations = current_user.reservations.includes(:room)
    end
  
    # 予約確認ページ
    def show
    end
  
    # 新規作成フォーム
    def new
      @reservation = Reservation.new
      @room = Room.find(params[:room_id])
    end
  
    # 作成処理
    def create
      @room = Room.find(params[:room_id])
      @reservation = current_user.reservations.new(reservation_params)
      @reservation.room = @room
  
      if @reservation.save
        redirect_to @reservation, notice: "予約が確定しました。"
      else
        flash.now[:alert] = "予約に失敗しました。入力内容をご確認ください。"
        render :new
      end
    end

      # 予約削除
      def destroy
        @reservation.destroy
        redirect_to reservations_path, notice: "予約を削除しました。"
      end

  # 予約確定処理
  def confirm
    if @reservation.update(confirmed: true)
      redirect_to reservations_path, notice: "予約が確定しました。"
    else
      flash[:alert] = "予約確定に失敗しました。"
      render :confirmation, status: :unprocessable_entity
    end
  end
  


    private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def set_reservation
        @reservation = current_user.reservations.find_by(id: params[:id])
      unless @reservation
        redirect_to reservations_path, alert: "予約が見つかりませんでした。"
      end
    end
  
    def reservation_params
      params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_guests)
    end
  end
  