class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :authenticate_user!
  
 include PublicActivity::StoreController
# ...
hide_action :current_user
  
  def after_sign_in_path_for(resource)
     path = (resource.id ==  1) ? admin_allusers_user_path : root_path
     return path
	
  end
  
end
