class EducDegrees < ActiveRecord::Base
  attr_accessible :name,
                  :description,
                  :approved_flag,
                  :approved_by

  has_many :candidates_education
  
  validates :name, :presence => true
end
