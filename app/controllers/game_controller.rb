class GameController < ApplicationController
  def play
  end
  def newteam
  	session[:team] = params[:teamname]
  	session[:score] = 0
  	render 'play'
  end
  def continue
  	new_points = params[:newpoints]
  	correct = (params[:status] == "success")
  	question_number = params[:question]

  	if correct
  		if session[:points]
  			session[:points] += new_points.to_i
  		else
  			session[:points] = new_points.to_i
		end  			
  	end
  	redirect_to action: 'play'
  end
end
