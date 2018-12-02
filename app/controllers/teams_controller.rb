class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  
  # check if users logged in, if not, prompt them to do so. if logged in they can create update an destory
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  # GET /teams
  # GET /teams.json 
  # order teams as well by created
  def index
    @teams = Team.all.order("created_at DESC")
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  # allow me to use these new varibles in my view - mvc design pattern. instaniating the user
  def new
    @team = current_user.teams.build
    @user = current_user
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    # find team and create
    @team = current_user.teams.build(team_params)
    # and then append own id to the team - add this current user to this array
    @team.users << current_user

    respond_to do |format|
      if @team.save
        format.html { redirect_to root_path, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, users_attributes: [:id, :name, :email, :_destroy])
    end
end
