class Interviewer < ActiveRecord::Base
  belongs_to :candidates_interviews

  attr_accessible :name,
                  :updated_by

  validates :name, :presence => true

end