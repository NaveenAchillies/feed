class Post < ApplicationRecord
	has_many :feed_views
	has_many :users, :through=>:feed_views
	has_many :comments
	belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
	after_commit :send_notif, on: :create
	require 'httparty'
	include HTTParty
	default_timeout 10

	def send_notif
		token = get_notif_token
		if token.present? && Thread.current[:current_user].present?
			users = User.where.not(:id=>Thread.current[:current_user].id,:subscribed=>false)
			users.each{|user|
				seen_posts = user.posts
				@unread_posts = Post.where.not(:id=>seen_posts.pluck(:id)).count
				params = { body: {:title=>"Feed Posts",:message=>"#{@unread_posts} new posts",:is_feed=>1}.to_json, headers: {'Token'=>token, 'Content-Type' => 'application/json'}}
				response = self.class.post('https://pushify.com/api/send-push',params)
			}
		end
	end

	def get_notif_token
		token = nil
		params = { body: {:email=>"yourmail@example.com",:pass=>'yourpassword'}.to_json, headers: { 'Content-Type' => 'application/json'}}
		response = self.class.post('https://pushify.com/api/authenticate',params)
		if response.code == 200
	      result = response.body
	      result = JSON.parse(result)
	      token = result['token']
	    end
		token
	end
end
