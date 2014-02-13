class AddLoginsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logins, :integer
  end
end
