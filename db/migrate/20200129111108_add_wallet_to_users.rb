class AddWalletToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :wallet, :integer, :default => 5000
  end
end
