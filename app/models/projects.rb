class Project < ActiveRecord::Base
  attr_accessible :company_name, :description, :end_date, :job_position, :resume_id, :start_date
  
  belongs_to :resume
  
  validates :resume_id, presence: true
end
