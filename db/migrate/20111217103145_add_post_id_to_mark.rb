class AddPostIdToMark < ActiveRecord::Migration
  def change
	add_column :marks, :post_id, :integer
  end
end
