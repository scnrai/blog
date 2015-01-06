class Answer < ActiveRecord::Base
  attr_accessible :content, :question_id, :weightage
  belongs_to :question
end
