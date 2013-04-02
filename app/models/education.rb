class Education < ActiveRecord::Base
  attr_accessible :university,
                  :degree,
                  :graduation_year,
                  :certifications

  belongs_to :candidate
  
  validates :university,         :presence => true
  validates :degree,   :presence => true
  validates :graduation_year,     :presence => true
  validates :certifications, :presence => true
end
