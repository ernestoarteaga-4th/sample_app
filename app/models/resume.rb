class Resume < ActiveRecord::Base
 
  attr_accessible :summary
  
  belongs_to      :user
  
  has_many        :experiences, :dependent => :destroy
  has_many        :idioms, :dependent => :destroy  

  validates :user_id, :presence => true
  
end
