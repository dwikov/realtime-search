class ActivitiesController < ApplicationController
  include ActivitiesHelper
  include ApplicationHelper

  DELETE_SECONDS_LIMIT = 30

  def index
    render json: unique_queries_count
  end

  # POST /activities or /activities.json
  def create
    render json: unique_queries_count and return if process_query(activity_params[:query]).blank?

    latest_query = Activity.where(user_session: user_session).order(created_at: :desc).first

    if !latest_query.nil? && check_if_similar(activity_params[:query], latest_query.query) && newly_created(latest_query)
      latest_query.delete
    end

    @activity = Activity.new(user_session: user_session, **activity_params)

    if @activity.save
      render json: unique_queries_count
    else
      render json: @activity.errors, status: :unprocessable_entity 
    end
  end

  private

    def unique_queries_count
      count_criteria = Activity.where(user_session: user_session).group(_id: '$query', count: { '$count' => {} })
      Activity.collection.aggregate(count_criteria.pipeline).to_a
    end

    def newly_created(latest_query)
      Time.now - latest_query.created_at < DELETE_SECONDS_LIMIT
    end

    def activity_params
      params.require(:activity).permit(:query)
    end

    def user_session
      cookie = request.headers["HTTP_COOKIE"].split(';').map{|c| c.split('=')}.to_h['_realtime_search_session']

      verify_and_decrypt_session_cookie(cookie)["session_id"]
    end
end
