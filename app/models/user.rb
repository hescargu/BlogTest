class User < ActiveRecord::Base
  has_many :posts
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates :password, :confirmation => true
  validates :password, :length => { :in => 6..12 }
  validates_presence_of :password_confirmation, :message => 'is required'
  validates_presence_of :email, :message => 'is required'
  validates :email, :uniqueness => true
  validates_associated :posts
end
