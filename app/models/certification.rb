class Certification < ActiveRecord::Base
  belongs_to :resume

  attr_accessible :id,
  :name,
  :description,
  :approved_flag,
  :approved_by

  validates :id, :presence => true
  validates :name, :presence => true
end
