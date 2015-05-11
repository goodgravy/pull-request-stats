module Api
  class ApiController < ActionController::Base
    rescue_from StandardError, with: :render_error
    protect_from_forgery with: :null_session

    private

    def render_error(error)
      @status = ErrorToHttpStatus[error]
      @error = error
      render 'api/errors/show', status: @status
    end
  end
end
