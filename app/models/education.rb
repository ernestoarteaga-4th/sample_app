class Education < ActiveRecord::Base
  attr_accessible :name,
                  :start_date,
                  :end_date,
                  :degree_level

  belongs_to :resume
  
  validates :name,         :presence => true
  validates :start_date,   :presence => true
  validates :end_date,     :presence => true
  validates :degree_level, :presence => true
end
