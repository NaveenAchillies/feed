class PostsController < ApplicationController

	def index
		seen_posts = current_user.posts
		@unread_posts = Post.where.not(:id=>seen_posts.pluck(:id))
		seen_posts << @unread_posts
		@seen_posts = seen_posts.includes(:owner,:comments).order("feed_views.created_at desc").as_json(:root=>false,:include=>[:comments,{:owner=>{:only=>[:email,:name]}}])
		respond_to do |format|
			format.html {}
		end
	end

	def show
		Post.where.not(:id=>seen_posts.pluck(:id))
		respond_to do |format|
			format.html {}
		end
	end

	def open_unread_posts
		seen_posts = current_user.posts
		seen_posts << Post.where.not(:id=>seen_posts.pluck(:id))
		redirect_to :action => 'index'
	end

	def create
		posts = current_user.posts.create(:notes=>params[:notes],:user_id=>current_user.id)
		redirect_to :action => 'index'
	end

	def destroy
		post = current_user.owner_posts.where(:id=>params[:id])[0]
		post.destroy if post.present?
		return redirect_to :back, :flash=>{:success=>'Successfully record deleted.'}
	end

end