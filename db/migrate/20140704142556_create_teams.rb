class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :points
    end
    create_table :teamanswers do |t|
    	t.integer :points
    	t.belongs_to :teams
    	t.belongs_to :questions
    end
  end
end
