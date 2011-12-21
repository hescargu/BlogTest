class Mark < ActiveRecord::Base
	belongs_to :posts
	validates :value, :post_id, :presence => true
	validates_format_of :value, :with => /\A[0-5]\Z/, :on => :create
	validates_associated :posts
end
