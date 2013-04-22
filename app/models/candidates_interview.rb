class CandidatesInterview < ActiveRecord::Base
  self.per_page = 10
  
  attr_accessible :candidate_id, :result, :interviewer_id, :interview_type_id, :comments

  #belongs_to :candidate
  
  validates :candidate_id, presence: true
  
  validates :interviewer_id, presence: true
  
  validates :interview_type_id, presence: true

end