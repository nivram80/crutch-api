class AddPreviousStateIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :previous_state_id, :integer
  end
end
