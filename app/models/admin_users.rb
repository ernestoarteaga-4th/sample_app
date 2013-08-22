class AdminUsers < ActiveRecord::Base
  attr_accessible :candidates_id, :edited_by, :is_active
  belongs_to         :candidate,  :dependent => :destroy,
  								  :foreign_key => 'candidates_id'
end
