module Api
  class GithubController < ApiController
    def sync
      UpdatePullRequests[]
    end
  end
end

