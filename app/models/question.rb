class Question < ActiveRecord::Base
	has_many :answers
	has_many :teams, through: :answers
end
