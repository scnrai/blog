class CommentsController < ApplicationController
	before_filter :authenticate_user!, only: [:create, :destroy]

	def create
		@status = Status.find(params[:comment][:status_id])
		@comment = Comment.new(params[:comment])
		@comment.user = current_user
		@comment.save
		redirect_to root_path
end
		


end
