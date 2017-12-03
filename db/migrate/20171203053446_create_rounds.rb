class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.string :name
      t.date :date, null: false
      t.integer :group_limit, null: false

      t.timestamps
    end
  end
end
