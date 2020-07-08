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

    def user_feed 
        user = User.find_by(id: params[:id])
        followees = user.followees
        feed = []
        followees.each {|f| f.tracks.each {|t|  feed << {id: t.id, title: t.title, audio: rails_blob_url(t.audio_data), username: t.user.username, user_id: t.user.id }}}
        p followees
        render json: {
            feed: feed
        }
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
