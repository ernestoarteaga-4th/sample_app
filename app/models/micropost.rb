require 'acts_as_ferret'

class Micropost < ActiveRecord::Base
  acts_as_ferret
  self.per_page = 5
  attr_accessible :content
  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
 
  default_scope :order => "microposts.created_at DESC" 
  
  def self.from_users_followed_by(user)
      followed_ids = user.following.map(&:id).join(", ")
      followed_ids = 0 if (followed_ids == nil || followed_ids.empty?)
      where("user_id IN (#{followed_ids}) OR user_id = ?", user) 
  end
  
  def self.search_from_users_followed_by(user, words)
      if user.following.count > 0
        followed_ids = user.following.map(&:id).join(", ")
        followed_ids = 0 if (followed_ids == nil || followed_ids.empty?)
        followed_ids.concat(", " + user.id.to_s)
      else
        followed_ids = user.id.to_s
      end
      where("content LIKE ? AND user_id IN (#{followed_ids})", "%#{words}%") 
  end
end 
