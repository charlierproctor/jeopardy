class AddTextToTeamAnswers < ActiveRecord::Migration
  def change
	add_column :answers, :text, :text
  end
end
