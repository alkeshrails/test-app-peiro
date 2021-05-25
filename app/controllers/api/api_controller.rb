class Api::ApiController < ::ApplicationController
  before_action :authenticate_request!

  def authenticate_request!
    unless request.headers["Authorization"] == "ValidAuthKey"
      render json: 401, status: :unauthorized
    end
  end
end
