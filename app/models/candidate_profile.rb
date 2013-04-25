class CandidateProfile < ActiveRecord::Base
  # attr_accessible :title, :body

  self.per_page = 10

  attr_accessible :name, :summary
  
  belongs_to :candidate
  
  validates :name,   		presence: true

  validates :summary,       	presence: true

  has_many        :candidate_profiles_tags,      :dependent => :destroy                                            
end
