# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1 or /movies/1.json
  def show; end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies or /movies.json
  def create
    movies = movie_params[:names].to_s.split(/\r?\n/).map(&:strip).reject(&:empty?)
    genre = movie_params[:genre]

    if movies.present? && genre.present?
      movies.sort!

      movie_records = movies.map { |name| Movie.new(name:, genre:) }
      saved = movie_records.all?(&:save)

      respond_to do |format|
        if saved
          format.html { redirect_to movies_path, notice: 'Movies were successfully created.' }
          format.json { render :index, status: :created, location: movie_records }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: movie_records.map(&:errors), status: :unprocessable_entity }
        end
      end
    else
      @movie = Movie.new
      @movie.errors.add(:base, 'Movie names and genre are required')
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(:genre, :names)
  end
end
