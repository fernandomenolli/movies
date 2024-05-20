class Movie < ApplicationRecord
  enum :genre, %i[action adventure drama comedy horror news]

  def self.rogers_order
    %i[action news adventure drama comedy horror]
  end
end
