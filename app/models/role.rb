class Role < ActiveRecord::Base
  attr_accessible :approved_by, :approved_flag, :description, :name

  has_many :projects_roles
  has_many :projects, :through => :projects_roles
end
