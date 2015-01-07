class UsersController < ApplicationController
	 before_filter :authenticate_user!, :only => [:edit, :update]
	 @@totalmarks =  0
	def admin_allusers
		if (current_user.id==1)
		@users=  User.paginate(:page => params[:page], :per_page => 5)
		@users =User.order(params[:user]).paginate(:page => params[:page], :per_page => 5) if params[:user].present?
		 @users=User.where(" fname LIKE :show OR email LIKE :show OR lname LIKE :show", { :show =>  "%#{params[:search]}%"  } ).paginate(:page => params[:page], :per_page => 5) if params[:search].present? 
		 else
			redirect_to root_path
		end
	end
	
	def new 
		@user = User.new 
	end
	
	def edit
		@user = User.find(params[:format])
	end
	
	
	def update
		@user =  current_user
		if @user.update_with_password(params[:user])
			redirect_to root_path, :notice => "Password updated successfully"
		else
			render :action => 'change_password' 
		end
	end
	
	def change_password
		@user = current_user	
	end
		
	def  editprofile
		#@user = User.find(params[:format])
		@user= User.find(params[:format])
		if @user.update_attributes(params[:user])
			redirect_to root_path, :notice => "Profile updated successfully"
		else
			render :action => 'edit'
		end
	end
	
	def show
		@user = User.find(params[:format])
	end	
	
	def destroy
		@user = User.find(params[:format])
		@user.destroy
		 redirect_to admin_allusers_user_url, :notice=> "User Deleted"
	end
	
	 def follow
		@user = User.find(params[:user])
		current_user.toggle_follow!(@user)
	end
	
	def unfollow
		@user = User.find(params[:user])
		current_user.unfollow!(@user)
	end
	
	 def like
		if params[:likeable_type] == "Status"
			@likeable = Status.find(params[:likeable_id])
		else
			@likeable = Comment.find(params[:likeable_id])
		end
		current_user.toggle_like!(@likeable)
	end
	
	def jsonuser
		@users = User.all
		render json: @users
	
	end
<<<<<<< HEAD
	
	def quizrem
		@marks = 0
		if params[:answer].present?
			answer  = Answer.find_by_id(params[:answer].to_i)
			@marks = answer.weightage
			@@totalmarks = @@totalmarks + @marks
=======
	def quizrem
		
		if params[:answer].present?
			answer  = Answer.find_by_id(params[:answer].to_i)
			marks = answer.weightage
			@@totalmarks = @@totalmarks + marks
>>>>>>> origin/master
		end
		
		@totalmarks = @@totalmarks
		id = params[:id].to_i + 1
		@question = Question.find_by_id(id)
		@@totalmarks = 0 if @question.nil?
		 respond_to do |format|
			format.js 
		end

	end
	
	def quiz
		@users = User.all
	end
end
