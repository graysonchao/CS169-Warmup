class AddLoginsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logins, :number
  end
end
