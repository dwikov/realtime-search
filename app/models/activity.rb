class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActivitiesHelper

  field :user_session, type: String
  field :query, type: String

  validates :query, presence: true, allow_blank: false
  validates :user_session, presence: true, allow_blank: false

  before_save :process_query_string

  private 

  def process_query_string
    self.query = process_query(query)
  end
end
