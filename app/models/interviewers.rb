class Interviewers < ActiveRecord::Base
  belongs_to :candidates_interviews

  attr_accessible :id, 
  :name

  validates :id, :presence => true
end