class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
