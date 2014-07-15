class QuestionsController < ApplicationController
  before_action :set_question, only: [:update, :destroy]

  def grade
    @answer = params[:answer]
    num = params[:question]
    @question = Question.find_by(number: num)
    @team_id = session[:team]
   
    #let's make sure they're not cheating, by trying to resubmit their answer to the question
    @team_answer = Answer.find_by(team_id: @team_id, question_id: @question.id)
    @team_answer.update_attributes(text: @answer)
    if @team_answer == nil
      redirect_to "/game/play"
    elsif @team_answer.points < 0
      flash[:message] = "Sorry, you can only submit your answer once."
      redirect_to "/game/play"
    else
      @team_answer.points = - (@question.points / 2)
      @team_answer.save
    end
      flash[:points_lost] = @question.points / 2
  end


  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.order(:number)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @team_id = session[:team]
    @question = Question.find_by(number: params[:id])

    #let's make sure they're not cheating, by trying to answer the question again
    if Answer.find_by(team_id: @team_id, question_id: @question.id) != nil
      flash[:message] = "Sorry, you can only view a question once."
      flash[:points_lost] = @question.points / 2
      redirect_to "/game/play"
    else
      Answer.create(team_id: @team_id, question_id: @question.id, points: 0)
    end

  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find_by(number: params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to '/questions', notice: 'Question was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to '/questions', notice: 'Question was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to '/questions', notice: 'Question was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:number, :points, :prompt, :tests, :input, :solution)
    end
end
