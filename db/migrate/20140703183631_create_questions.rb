class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :number
      t.integer :points
      t.text :prompt
      t.text :tests

      t.timestamps
    end
  end
end
