class Comment < ActiveRecord::Base
  belongs_to :status
  belongs_to :user
  attr_accessible :content, :status_id
  acts_as_likeable
 include PublicActivity::Model
tracked owner: ->(controller, model) { controller && controller.current_user }
end
