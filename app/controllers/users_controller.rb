class UsersController < ApplicationController

    def user 
        user = User.find_by(id: params[:id])
        render json: user
    end

    def create
        user = User.create(create_user_params)
        render json: user
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

    # params functions
    def create_user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
