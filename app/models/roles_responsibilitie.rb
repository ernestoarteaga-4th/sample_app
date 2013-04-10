class RolesResponsibilitie < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :description, :projroles_id
  
  belongs_to :projroles
  
  validates :projroles_id,   presence: true
  
  validates :description,    presence: true

end
