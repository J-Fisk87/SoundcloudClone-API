class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :audio_data
      t.string :title
      t.references :user

      t.timestamps
    end
  end
end
