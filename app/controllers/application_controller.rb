class ApplicationController < ActionController::Base
  before_action :set_session

  def set_session
    response.set_cookie(
      '_realtime_search_session',
      {
        value: user_session,
        expires: 1.year.from_now,
        path: '/',
        secure: Rails.env.production?,
        httponly: Rails.env.production?
      }
    )
  end

  def user_session
    request.headers["HTTP_COOKIE"].split(';').map{|c| c.split('=')}.to_h['_realtime_search_session']
  end
end
