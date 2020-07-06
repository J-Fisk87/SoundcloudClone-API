class Track < ApplicationRecord
    has_one_attached :audio_data
    belongs_to :user
end
