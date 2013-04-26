class Project < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :candidate_id, :name, :summary, :company_name
  
  belongs_to :candidates
  
  has_many   :projects_roles,           :dependent => :destroy
  has_many :roles, :through => :projects_roles
  
  validates :candidate_id, presence: true
  
  validates :company_name,  :presence => true,
                            :length   => { :maximum => 255 }

  validates :name,          :presence => true,
                            :length   => { :maximum => 255 }
  
  validates :summary,       :presence => true,
                            :length   => { :maximum => 255 }
end