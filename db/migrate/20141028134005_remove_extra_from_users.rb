class RemoveExtraFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :remember_created_at, :string
    remove_column :users, :token, :string
    remove_column :users, :token_secret, :string
  end
end
