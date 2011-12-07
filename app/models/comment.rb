class Comment < ActiveRecord::Base
	belongs_to :posts
	validates :author, :body, :presence => true
        validates :author, :length => { :in => 2..30 }
	validates :body, :length => { :in => 2..500 }
end
