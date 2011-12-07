class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :users
	validates :title, :body, :presence => true
	validates :title, :length => { :in => 2..50 }
	validates :body, :length => { :in => 2..500 }
end
