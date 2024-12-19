class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  # バリデーション
  validates :check_in_date, :check_out_date, :number_of_guests, presence: true
  validate :check_in_date_must_be_in_the_future
  validate :check_out_date_must_be_after_check_in_date
  validates :number_of_guests, numericality: { greater_than_or_equal_to: 1 }

  # 宿泊日数を計算
  def total_days
    (check_out_date - check_in_date).to_i
  end

  # 合計料金を計算
  def total_price
    total_days * number_of_guests * room.price
  end

  private

  # チェックイン日が未来であることを確認
  def check_in_date_must_be_in_the_future
    return if check_in_date.blank?
    if check_in_date < Date.today
      errors.add(:check_in_date, "は今日以降の日付を選択してください")
    end
  end

  # チェックアウト日がチェックイン日より後であることを確認
  def check_out_date_must_be_after_check_in_date
    return if check_in_date.blank? || check_out_date.blank?
    if check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日より後の日付を選択してください")
    end
  end
end
