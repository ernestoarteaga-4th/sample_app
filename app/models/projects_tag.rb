class ProjectsTag < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :date_in, :date_out, :description, :tags_id, :projroles_id
  
  belongs_to :projroles
  
  validates :tags_id,       presence: true
  
  validates :description,   presence: true

  validates :date_in,       presence: true
  
  #validates :date_out,     presence: true

end
