class CandidateState < ActiveRecord::Base
  attr_accessible :description

  belongs_to :candidate
  
  validates :description,         :presence => true
end
