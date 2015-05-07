module Api
  class PullRequestsController < ApiController
    def index
      render json: PullRequest.all
    end
  end
end
