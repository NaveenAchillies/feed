class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :current_thread

	def current_thread
		Thread.current[:current_user] = current_user if current_user.present?
	end

end
