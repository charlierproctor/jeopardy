class AddColumnInputs < ActiveRecord::Migration
  def change
  	add_column :questions, :input, :text
  end
end
