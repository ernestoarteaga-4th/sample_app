class CandidatesEducation < ActiveRecord::Base
  attr_accessible :id,
                  :educ_degrees_id,
                  :candidate_id,
                  :title,
                  :degree,
                  :date_in,
                  :date_out,
                  :university

  belongs_to :educ_degrees
  has_many :candidate
  
  validates :educ_degrees_id, :presence => true
  validates :candidate_id, :presence => true
  validates :title, :presence => true
end
