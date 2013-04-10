class Role < ActiveRecord::Base
  attr_accessible :approved_by, :approved_flag, :description, :name
end
