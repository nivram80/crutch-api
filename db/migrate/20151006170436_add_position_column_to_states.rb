class AddPositionColumnToStates < ActiveRecord::Migration
  def change
    add_column :states, :position, :integer
  end
end
