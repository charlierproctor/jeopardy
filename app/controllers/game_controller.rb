class GameController < ApplicationController
  def play
    @team = Team.find(session[:team])
    @answered_questions = []
    @team.questions.each {|question| @answered_questions << question.number}
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
    #grab info from params / session
    @team = Team.find(session[:team])
  	new_points = params[:points]
    question_number = params[:question_number]

    #create the appropriate answer link with the right number of points
    answer = Answer.find_by(team_id: @team.id, question_id: question_number)  #id with number??
    answer.update_attributes(points: new_points)
    
    #update the team's total points
    @team.points = new_points
    @team.save

  	redirect_to action: 'play'
  end

end
