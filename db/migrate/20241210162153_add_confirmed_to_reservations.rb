class AddConfirmedToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :confirmed, :boolean
    add_column :reservations, :default, :false
  end
end
