class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false                   # 施設名（必須）
      t.text :description, null: false             # 施設詳細（必須）
      t.integer :price, null: false                # 宿泊料金（必須）
      t.string :address, null: false               # 住所（必須）
      t.string :image_url                          # 施設画像URL

      t.timestamps
    end
  end
end
