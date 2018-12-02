class Team < ApplicationRecord
    
    #I am going to allow for many events for a team - if main user is destroyed then soo will the projects at the moment
    has_many :events, dependent: :destroy
    has_many :users
    
    accepts_nested_attributes_for :users, allow_destroy: true
    ##include this in the activity tracking
    include PublicActivity::Model
    tracked owner: Proc.new { |controller, model| controller.current_user}
end
