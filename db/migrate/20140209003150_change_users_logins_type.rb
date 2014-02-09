class ChangeUsersLoginsType < ActiveRecord::Migration
  def change
    change_column :users, :logins, :integer
  end
end
