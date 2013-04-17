class CandidateProfile < ActiveRecord::Base
  # attr_accessible :title, :body

  self.per_page = 10

  attr_accessible :candidate_id, :profile_id, :summary
  
  belongs_to :candidate
  
  validates :candidate_id,      presence: true
  
  validates :profile_id,   		presence: true

  validates :summary,       	presence: true

  belongs_to :candidate

  has_many        :candidate_profiles_tags,      :dependent => :destroy                                            
end
