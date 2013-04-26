class CandidatesProfile < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :candidate_id, :name, :summary
  
  belongs_to :candidate
  
  validates :candidate_id,	:presence => true
  validates :name,   		:presence => true

  validates :summary,       :presence => true

  has_many        :candidate_profile_tags,      :dependent => :destroy                                            
end