class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :details
      t.integer :priority, default: 1

      t.timestamps null: false
    end
  end
end
