class AdminUsers < ActiveRecord::Base
  attr_accessible :candidates_id, :edited_by, :is_active
end
