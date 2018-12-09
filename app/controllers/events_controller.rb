##logger for logging when new events are creat and writes to log file - uses the singleton design pattern 
require 'my_logger'
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order("created_at DESC")
  end
  

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new 
  # new method on a event trying to find the team name (querying db) and pull out. so can display the team
  def new
    @event = current_user.events.build
    @teams = Team.where('id = ?', current_user.team_id)
  end

  # GET /events/1/edit
  # need to find teams to edit - bit of an odd end usecase.
  def edit
    
    @teams = current_user.teams
    
  end

  # POST /events
  # POST /events.json 
  # redirect to event after create it
  def create
    
    @event = current_user.events.build(event_params)
    logger = MyLogger.instance
    logger.logInformation("An event was created")
    
   
    # logger.logInformation(Time.now.strftime('%m/%d/%y %h:%m %p') + @event.name + "An event was created")

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json 
  # redirect to event after edit/update it
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json  add teamid here also to whitelist these and pass them through form so know they are secure. after destroy event, redircect to the root path
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions. save having to put this into every action
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through. rails can psas the below params now through a form
    def event_params
      params.require(:event).permit(:name, :description, :team_id)
    end
    
end
