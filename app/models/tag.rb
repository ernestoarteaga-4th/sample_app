class Tag < ActiveRecord::Base
  attr_accessible :id,
                  :description, 
                  :name, 
                  :type_tag

  has_many :projects_tag, :dependent => :destroy
end
