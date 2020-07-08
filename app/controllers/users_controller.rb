class UsersController < ApplicationController

    def user 
        user = User.find_by(id: params[:id])
        render json: user
    end

    def create
        @user = User.new(create_user_params)
        if @user.save
          login!
          render json: {
            status: :created,
            user: @user
          }
        else 
          render json: {
            status: 500,
            errors: @user.errors.full_messages
          }
        end
      end

    def follow_user
        user = User.find_by(id: params[:id])
        user_to_follow = User.find_by(id: params[:follower_id])
        user_to_follow.followers << user
        render json: user
    end

    def unfollow_user
        user = User.find_by(id: params[:id])
        user_to_unfollow = User.find_by(id: params[:follower_id])
        user_to_unfollow.followers.delete(user)
        render json: user
    end

    private 
    # params functions
    def create_user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
