class TeamsController < ApplicationController
	def show
		@teams = Team.all
		@questions = Question.all
	end
	def newgame
		Team.destroy_all
		Answer.destroy_all
		redirect_to '/questions'
	end
	def clearpoints
		Answer.destroy_all
		Team.all.each do |team|
			team.points = 0
			team.save			
		end
		redirect_to '/questions'
	end
end
