class ProjectsRole < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :date_in, :date_out, :project_id, :role_id
  
  belongs_to   :projects,                    :dependent => :destroy
  
  belongs_to   :roles
  has_many     :projects_tags
  has_many     :roles_responsibilities

  
  validates :project_id, presence: true
  
  validates :role_id,    presence: true

  validates :date_in,    :presence => true
  
  #validates :date_out,   :presence => true
  
  def tags1
    return projects_tags.where("tags_id in (select id from tags where type_tag=?)",1)
  end
  
  def tags2
    return projects_tags.where("tags_id in (select id from tags where type_tag=?)",2)
  end
  
  def tags3
    return projects_tags.where("tags_id in (select id from tags where type_tag=?)",3)
  end
  
end
