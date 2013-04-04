class Certification < ActiveRecord::Base
  

  attr_accessible :id,
  :name,
  :description,
  :approved_flag,
  :approved_by

  validates :name, :presence => true
end
