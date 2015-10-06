class RemoveDefaultFromPriorityInTickets < ActiveRecord::Migration
  def change
  	change_column_default(:tickets, :priority, nil)
  end
end
