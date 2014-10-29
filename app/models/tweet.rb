class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :screenname, presence: true
  validates :name, presence: true
  validates :text, presence: true
  validates :date, presence: true
  validates :tweetid, presence: true, uniqueness: true

end