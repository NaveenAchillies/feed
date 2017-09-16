class CommentsController < ApplicationController

	def create
		posts = Post.where(:id=>params[:id])[0].comments.create(:notes=>params[:notes],:user_id=>current_user.id)
		redirect_to root_path
	end

end