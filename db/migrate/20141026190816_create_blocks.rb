class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :screen_name
      t.string :name
      t.string :created_at
      t.string :twitter_id
      t.references :user, index: true
    end
  end
end
