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
  has_many :retweets
  
  validates :name, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
  
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  
  # validates :retweeter, :uniqueness => {scope: :user_id, :message => "You already retweeted"}
  # validates :retweet, :uniqueness => {scope: :current_user, :message => "You already retweeted"}
  
  def retweet_by(retweeter)
    if self.user == retweeter
      "Sorry, you can't retweet your own tweets"
    elsif self.retweets.where(:user_id => retweeter.id).present?
      "You already retweeted!"
    else
      t = Micropost.new
      t.name = "RT #{self.user.name}: #{self.name}"
      t.user = retweeter
      t.save
      "Succesfully retweeted"
    end
  end

  def self.retweets
    micropost = Micropost.find(params[:id])
  end

  private
    
  def self.followed_by(user)
        followed_user_ids = %(SELECT followed_id FROM relationships
                              WHERE follower_id = :user_id)
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
        { user_id: user })
  end
  
  
end