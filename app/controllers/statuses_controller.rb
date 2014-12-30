class StatusesController < ApplicationController

	def create 
		@status = current_user.statuses.new(params[:status]) 
		if @status.save 
			render 'create'
		else 
			respond_to do |format|
				format.html { redirect_to root_path, :alert => 'Unable to add comment'  }
				format.js { render 'fail_create.js.erb' }
			end 
		end 
	end
	
	def show
		 @comment = Comment.new
		@status = Status.find(params[:id])
		@comments = @status.comments

		respond_to do |format|
			format.html 
			format.json { render json: @status }
		end
	end

end



