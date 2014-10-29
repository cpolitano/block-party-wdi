class Block < ActiveRecord::Base
  belongs_to :user
  has_one :tweet

  validates :screen_name, presence: true
  validates :name, presence: true
  validates :created_at, presence: true
  # validates :twitter_id, presence: true

  def self.create_block(blocked_user, current_user) 
    Block.where(screen_name: blocked_user.screen_name, user_id: current_user.id).first_or_create do |block|
        block.name = blocked_user.name
        block.screen_name = blocked_user.screen_name
        block.created_at = blocked_user.created_at
        block.twitter_id = blocked_user.id_str
        block.user_id = current_user.id
    end
  end

end