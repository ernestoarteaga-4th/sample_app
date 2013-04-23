class InterviewsType < ActiveRecord::Base
  belongs_to :candidates_interviews

  attr_accessible :id, :name

  validates :name, :presence => true
end