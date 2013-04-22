class CandidateProfileTag < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :candidate_profiles_id, :tags_id, :projects_roles_id  
  
  #validates :candidate_profiles_id,      presence: true
  
  #validates :tags_id,   		presence: true

  #validates :projects_roles_id,       	presence: true

  belongs_to :candidate_profile

end
