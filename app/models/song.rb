class Song < ApplicationRecord
    validates :title, presence: true
    validate :title_check
    validate :release_check

    def title_check
        relevant_songs = Song.where(release_year: self.release_year, artist_name: self.artist_name).pluck(:title)
        
        if relevant_songs.include?(self.title)
            errors.add(:title_check, "this title has already been release this year")
        end

    end

    def release_check

        if self.release_year && self.release_year > Date.today.year
            errors.add(:releasey, "release date can't be in future")
        end
        
        if self.released
            if !self.release_year || self.release_year > Date.today.year + 1
                errors.add(:release_check, "release date invalid")
            end
        end

    end

end
