class GameController < ApplicationController
  def play
    @team = Team.find(session[:team])
    @answered_questions = []
    @team.questions.each {|question| @answered_questions << question.number}
    @message = flash[:message]
    @points = flash[:points_lost]
    if @points != nil && @points != 0
      @team.points -= @points
      @team.save
      if @message == nil
        @message = "You broke the system."
      end
    end
    @status = flash[:status]
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
    question_id = params[:question_id]

    #create the appropriate answer link with the right number of points
    answer = Answer.find_by(team_id: @team.id, question_id: question_id)  #id with number??
    answer.update_attributes(points: new_points)
    
    if new_points.to_i < 0
      flash[:message] = new_points + " points losts."
      flash[:status] = "failure"
    else
      flash[:message] = new_points + " points earned."
      flash[:status] = "success"
    end

    #update the team's total points
    @team.points += new_points.to_i
    @team.save

  	redirect_to action: 'play'
  end

end
