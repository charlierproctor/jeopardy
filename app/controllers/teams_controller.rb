class TeamsController < ApplicationController
	def show
		@teams = Team.all
		@questions = Question.all
	end
end
