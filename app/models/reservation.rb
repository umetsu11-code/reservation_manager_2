class Reservation < ApplicationRecord
  # 一つの宿泊施設が一人に紐づくように設定
  belongs_to :user
  belongs_to :room
  
  # バリデーション
  validates :check_in_date, :check_out_date, :number_of_guests, presence: true
  validate :check_in_date_must_be_in_the_future
  validate :check_out_date_must_be_after_check_in_date
  validates :number_of_guests, numericality: { greater_than_or_equal_to: 1 }

    # 宿泊日数を計算かつpublicに
    def total_days
      (check_out_date - check_in_date).to_i
    end
  
    # 合計料金を計算かつpublicに
    def total_price
      total_days * number_of_guests * room.price
    end


  private

  # チェックイン日が今日以降であることを確認
  def check_in_date_must_be_in_the_future
    return if check_in_date.blank? || check_out_date.blank?
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "は今日以降の日付を指定してください")
    end
  end

  # チェックアウト日がチェックイン日より後であることを確認
  def check_out_date_must_be_after_check_in_date
    return if check_in_date.blank? || check_out_date.blank?
    if check_out_date.present? && check_in_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日より後の日付を指定してください")
    end
  end


end
