class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.integer :value
      t.timestamps
    end
  end
end
