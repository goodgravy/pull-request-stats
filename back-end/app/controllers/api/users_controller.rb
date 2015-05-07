module Api
  class UsersController < ApiController
    def index
      @users = User.all
    end

    def show
    end
  end
end
