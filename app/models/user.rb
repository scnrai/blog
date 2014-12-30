class User < ActiveRecord::Base
has_many :statuses
has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fname, :lname, :picture, :resume
  # attr_accessible :title, :body
  
  has_attached_file :picture, :default_url => ActionController::Base.helpers.asset_path(":style/missing.png")
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  #validates_attachment_content_type :picture, :content_type => /\Aimage/
  
   has_attached_file :resume, :default_url => ActionController::Base.helpers.asset_path(":style/missing.png")
 validates_attachment_content_type :resume, :content_type =>['application/pdf', 'application/xlsx'], :message => ', Only PDF, EXCEL, WORD or TEXT files are allowed. '
 #do_not_validate_attachment_file_type :resume
 #do_not_validate_attachment_file_type :picture
  
acts_as_followable
acts_as_follower
acts_as_liker
  
  
  def self.from_omniauth(auth)
	where(provider: auth.provider, uid: auth.id).first_or_create do |user|
		user.email = auth.info.email
		user.password = Devise.friendly_token[0,20]
		 user.fname = auth.info.name
		 #user.image= auth.info.image
		 user.picture = process_uri(auth.info.image)
	end
 end
 
	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end
	end
	
	def self.process_uri(uri)
		picture_url = URI.parse(uri)
		picture_url.scheme = 'https'
		picture_url.to_s
	end
	
end
