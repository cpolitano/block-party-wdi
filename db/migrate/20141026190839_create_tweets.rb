class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :screenname
      t.string :name
      t.string :text
      t.string :date
      t.string :link_url
      t.string :created_at
      t.string :location
      t.string :tweetid
      t.references :user, index: true
    end
  end
end
