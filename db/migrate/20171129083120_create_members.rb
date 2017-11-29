class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name , null: false
      t.boolean :working_flg, null: false

      t.timestamps
    end
  end
end
