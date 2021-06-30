module Api::V1
  class BaseController < ::ApplicationController

    skip_before_action :verify_authenticity_token
    def response_error(error)
      render json: { code: 201, errors: error }
    end
  end
end
