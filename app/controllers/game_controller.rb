class GameController < ApplicationController
  def play
    @team = Team.find(session[:team])
    @message = flash[:message]
  end
  def newteam
    @team = Team.find_by(name: params[:teamname])
    if @team == nil
      @team = Team.create(name: params[:teamname], points: 0)
    end
    session[:team] = @team.id
  	redirect_to action: 'play'
  end
  def continue
    @team = Team.find(session[:team])

  	new_points = params[:newpoints]
  	correct = (params[:status] == "success")
  	question_number = params[:question]

  	if correct
      @team.update_attributes(points: @team.points + new_points)
      # @team.questions.create() ?? link team with answer
  	end
  	redirect_to action: 'play'
  end
end
