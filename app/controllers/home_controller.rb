class HomeController < ApplicationController
  def index
    ## need some variables that will assciote to the right things. asscociate teams and events but see if user is signed in first
    if user_signed_in?
     @teams = Team.where('id = ?', current_user.team_id)
     @events = Event.where('team_id = ?', current_user.team_id)
    end
    
    ##set activites query
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_id: current_user, owner_type: "User")
  end
end
