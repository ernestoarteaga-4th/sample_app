class Education < ActiveRecord::Base
  attr_accessible :candidate_id,
                  :name,
                  :start_date,
                  :end_date,
                  :university,
                  :degree,
                  :graduation_year,
                  :certifications

  belongs_to :candidate
  
  validates :university,         :presence => true
  validates :degree,   :presence => true
  validates :start_date,     :presence => true
  validates :end_date,     :presence => true
  validates :name, :presence => true
end
