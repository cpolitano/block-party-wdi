class Block < ActiveRecord::Base
  belongs_to :user

  validates :screen_name, presence: true
  validates :name, presence: true
  validates :created_at, presence: true
  # validates :twitter_id, presence: true

end