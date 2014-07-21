class Post < ActiveRecord::Base
    belongs_to :user
	validates :user_id, presence: true
	validates :content, presence: true
	validates :title, presence: true, length: {maximum:20}
	default_scope { order('created_at DESC')}
end
