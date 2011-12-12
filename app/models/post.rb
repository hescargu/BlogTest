class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :users
	validates :title, :body, :user_id, :presence => true
	validates :title, :length => { :in => 2..50 }
	validates :body, :length => { :in => 2..500 }
end
