class RolesResponsibility < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :description, :projects_roles_id
  
  belongs_to :projects_roles
  
  validates :projects_roles_id,   presence: true
  
  validates :description,         presence: true

end
