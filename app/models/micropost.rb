# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  spotify    :string(255)
#  itunes     :string(255)
#  link       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Micropost < ActiveRecord::Base
  attr_accessible :name, :link_url
  belongs_to :user
  
  validates :name, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
  
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  private
    
  def self.followed_by(user)
        followed_user_ids = %(SELECT followed_id FROM relationships
                              WHERE follower_id = :user_id)
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
        { user_id: user })
  end
end