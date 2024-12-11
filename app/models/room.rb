class Room < ApplicationRecord
  has_one_attached :image
    # バリデーション
    validates :name, :description, :price, :address, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 1 }
  
    # 検索用スコープ
    scope :search_by_area, ->(area) { where("address LIKE ?", "%#{area}%") }
    scope :search_by_keyword, ->(keyword) {
      where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
    }
  # Ransackで検索可能な属性 のちに住所のみを検索対象とするように設定しなおし
  def self.ransackable_attributes(auth_object = nil)
    ["address", "name", "description", "price", "created_at", "updated_at"]
  end

  # Ransackで検索可能な関連付け
  def self.ransackable_associations(auth_object = nil)
    ["reservations", "user"] # 検索対象とする関連名を列挙
  end
  # 施設詳細に予約機能を付与するための関連付け
  has_many :reservations, dependent: :destroy

  belongs_to :user

    # デフォルト画像の処理
    def image_with_default
      if image.attached?
        image
      else
        'default-room-image.jpg' # public/images 内にデフォルト画像を保存
      end
    end

  end
  
