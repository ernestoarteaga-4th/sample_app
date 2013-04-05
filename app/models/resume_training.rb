class ResumeTraining < ActiveRecord::Base
  attr_accessible :description, :name, :year, :resume_id

  belongs_to :resume
end
