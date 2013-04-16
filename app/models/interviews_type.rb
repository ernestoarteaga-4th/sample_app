class InterviewsType < ActiveRecord::Base
  belongs_to :candidates_interviews

  attr_accessible :id, :description

  validates :id, :presence => true
end