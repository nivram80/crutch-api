class AddStateIdColumnToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :state_id, :integer
  end
end
