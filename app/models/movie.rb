class Movie < ApplicationRecord
  enum :genre, %i[action adventure drama comedy horror]
end
