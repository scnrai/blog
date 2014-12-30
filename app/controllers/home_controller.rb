class HomeController < ApplicationController
	skip_before_filter :authenticate_user!
	
	def index
		if user_signed_in?
			if (current_user.id==1)
			redirect_to admin_allusers_user_path
			end
			@user= current_user
			followees_ids = current_user.followees(User).map(&:id)
			@activities = PublicActivity::Activity.where(owner_id: followees_ids, owner_type: "User")
		else
			
			@message= "Welcome"
	#	render :layout => false
		end
	end
	
	def generate_random_numbers
		
	#	render :text => "Random No: #{rand(1..50)}"
	end
	
	

end
