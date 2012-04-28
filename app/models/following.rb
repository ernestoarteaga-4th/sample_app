class Following < ActiveRecord::Base
  belongs_to :user

  validates :user_id,     :presence => true
  validates :follow_user, :presence => true  
end
