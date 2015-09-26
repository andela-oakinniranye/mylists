class AddLoginStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_status, :integer, default: 0
  end
end
