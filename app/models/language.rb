class Language < ActiveRecord::Base
  attr_accessible :name,
		  :description,
                  :approved_flag,
		  :approved_by
  validates :name, :presence => true, :length => { :maximum => 50 }
  
  before_save :default_values

  def default_values
    self.approved_flag ||= false
  end
  
end
