class AddNoteToPost < ActiveRecord::Migration
  def change
	add_column :posts, :note, :float
  end
end
