class TracksController < ApplicationController
    def create 
        p params
        user = User.find_by(id: params[:user_id])
        track = Track.create(title: params[:title], audio_data: params[:audio_data])
        user.tracks << track
        render json: track
    end

    def track
        track = Track.find_by(id: params[:id])
        render json: {track: {id: track.id, title: track.title, audio: rails_blob_url(track.audio_data)}}
    end

    def search_tracks
        tracks = Track.where("title like ?", "%#{params[:search_text]}%")
        formatted_tracks = tracks.map {|t| {id: t.id, title: t.title, audio: rails_blob_url(t.audio_data), username: t.user.username, user_id: t.user.id, created_at: t.created_at }}
        render json: {
            tracks: formatted_tracks
        }
    end


    # params functions
    def create_track_params
        params.require(:track).permit(:title, :audio_data)
    end
end
