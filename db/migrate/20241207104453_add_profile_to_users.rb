class AddProfileToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :introduction, :text
    add_column :users, :icon, :string
  end
end
