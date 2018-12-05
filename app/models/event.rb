class Event < ApplicationRecord
    ## adding some relations between the event and the team and user - these can belong to both the team and the user
    belongs_to :team
    belongs_to :user
    
    ##when new event created I do want to assign it to a team
    accepts_nested_attributes_for :team
    
    include PublicActivity::Model
    tracked owner: Proc.new { |controller, model| controller.current_user}
    
    ##for photos added to events - use s3
    ##has_one_attached :event_picture
    ##event_picture.attach(params[:event_picture])
end
