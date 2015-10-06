class AddNullFalseToTitleAndDetails < ActiveRecord::Migration
  def change
    change_column_null :tickets, :title, false
    change_column_null :tickets, :details, false
  end
end
