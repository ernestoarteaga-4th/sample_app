class CandidatesInterviews < ActiveRecord::Base
  has_many :interviewers
  has_many :interviews_types

  attr_accessible :id, 
  :candidate_id,
  :result,
  :interviewer_id,
  :interview_type_id,
  :comments

  validates :id, :presence => true
end