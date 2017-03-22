class UsersUsernameNullable < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :username, true
  end
end
