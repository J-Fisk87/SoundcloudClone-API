class TracksController < ApplicationController
    def create 
        p params
        user = User.find_by(id: params[:user_id])
        track = Track.create(create_track_params)
        user.tracks << track
        render json: track
    end

    def track
        track = Track.find_by(id: params[:id])
        render json: {track: {id: track.id, title: track.title, audio: rails_blob_url(track.audio_data)}}
    end


    # params functions
    def create_track_params
        params.require(:track).permit(:title, :audio_data)
    end
end
