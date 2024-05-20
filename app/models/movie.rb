class Movie < ApplicationRecord
  enum :genre, %i[action news adventure drama comedy horror]
end
