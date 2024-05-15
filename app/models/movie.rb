class Movie < ApplicationRecord
  enum :genre, %i[action adventure drama comedy horror]

  def self.count_by_genre
    genre_counts = group(:genre).count
    genres.keys.map { |genre| [genre, genre_counts[genre] || 0] }.to_h
  end
end
