class ChangeBelongsToRelationshipsInAnswersTable < ActiveRecord::Migration
  def change
  	change_table :answers do |t|
  		t.rename :teams_id, :team_id 
  		t.rename :questions_id, :question_id
  	end
  end
end
