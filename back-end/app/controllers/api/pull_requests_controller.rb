module Api
  class PullRequestsController < ApiController
    def index
      @pull_requests = PullRequest.all
    end
  end
end
