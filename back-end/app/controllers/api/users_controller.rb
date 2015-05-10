module Api
  class UsersController < ApiController
    def index
      @users = User.all
    end

    def show
      @user = User.first
    end
  end
end
