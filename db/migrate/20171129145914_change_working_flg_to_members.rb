class ChangeWorkingFlgToMembers < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:members, :working_flg, true)
  end
end
