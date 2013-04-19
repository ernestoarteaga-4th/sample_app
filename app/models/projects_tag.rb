class ProjectsTag < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :date_in, :date_out, :description, :tags_id, :projects_roles_id
  
  belongs_to :projects_roles
  belongs_to :tags
  
  validates :tags_id,       presence: true
  
  validates :description,   presence: true

  validates :date_in,       presence: true
  
  #validates :date_out,     presence: true

end
