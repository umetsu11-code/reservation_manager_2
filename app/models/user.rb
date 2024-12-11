class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	# Deviseのモジュールやその他のロジック
    # パスワードを変更する場合のみバリデーションを実行
    validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  # ユーザー情報のバリデーションを追加
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 300 }
  
  has_many :reservations, dependent: :destroy
  has_one_attached :icon # Active Storageを使う場合の追記
  has_many :rooms, dependent: :destroy  
end
