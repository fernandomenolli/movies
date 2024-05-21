# frozen_string_literal: true

class Movie < ApplicationRecord
  enum :genre, %i[action adventure drama comedy horror news]

  def self.rogers_order
    %i[action news adventure drama comedy horror].map do |genre|
      [I18n.t("activerecord.attributes.movie.genres.#{genre}"), genre]
    end
  end
end
