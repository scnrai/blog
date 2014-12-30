class Status < ActiveRecord::Base
belongs_to :user
has_many :comments
 attr_accessible :post, :posted_at, :user_id
 acts_as_likeable
  include PublicActivity::Model
tracked owner: ->(controller, model) { controller && controller.current_user }
end
