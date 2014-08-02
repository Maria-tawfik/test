class Post < ActiveRecord::Base
    belongs_to :user
	validates :user_id, presence: true
	validates :content, presence: true
	validates :title, presence: true, length: {maximum:20}
	default_scope { order('created_at DESC')}
	def self.form_users_followed_by(user)
		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", { user_id: user.id} )
	end
end
