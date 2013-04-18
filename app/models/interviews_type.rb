class InterviewsType < ActiveRecord::Base
  belongs_to :candidates_interviews

  attr_accessible :id, :description

  validates :description, :presence => true
end