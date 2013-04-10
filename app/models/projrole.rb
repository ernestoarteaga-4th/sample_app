class Projrole < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :date_in, :date_out, :projects_id, :roles_id
  
  belongs_to :projects
  
  has_many   :roles_responsibilities,   :foreign_key => "projroles_id",
                                        :dependent => :destroy
  
  validates :projects_id, presence: true
  
  validates :roles_id,    presence: true

  validates :date_in,    :presence => true
  
  #validates :date_out,   :presence => true
  
end
