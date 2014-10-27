class AddTwitterColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_screen_name, :string
    add_column :users, :twitter_display_name, :string
  end
end
