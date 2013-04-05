class CandidateCertification < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :certification

  attr_accessible :certification_id,
  :candidate_id,
  :year

  #validates :id, :presence => true
  #validates :year, :presence => true
end
