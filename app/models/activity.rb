class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActivitiesHelper

  field :user_session, type: String
  field :query, type: String

  validates :query, presence: true, allow_blank: false
  validates :user_session, presence: true, allow_blank: false

  private 
end
