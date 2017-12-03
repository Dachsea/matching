class CreateRoundMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :round_members do |t|
      t.references :round, foreign_key: true
      t.references :member, foreign_key: true
      t.integer :group_number

      t.timestamps
    end
  end
end
