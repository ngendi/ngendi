class Profile < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  attr_accessible :name, :birhtday, :bio, :twitter, :facebook
end
