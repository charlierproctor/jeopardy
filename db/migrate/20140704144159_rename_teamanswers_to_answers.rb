class RenameTeamanswersToAnswers < ActiveRecord::Migration
  def change
  	rename_table :teamanswers, :answers
  end
end
