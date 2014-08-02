class Relationship < ActiveRecord::Base

	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"

	validated :follower_id, presence: true
	validated :followed_id, presence: true
end
