class CandidateProfSummary < ActiveRecord::Base
  belongs_to :candidate;

  attr_accessible :summary
  
  validates :summary, :presence => true
end
