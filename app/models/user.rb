class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :lockable, :timeoutable
	has_many :feed_views
  	has_many :posts, :through => :feed_views
  	has_many :owner_posts, :class_name => "Post", :foreign_key => "user_id"
	has_many :comments
end
