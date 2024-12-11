class AddColumnsToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :check_in_date, :date, null: false
    add_column :reservations, :check_out_date, :date, null: false
    add_column :reservations, :number_of_guests, :integer, null: false
  end
end
