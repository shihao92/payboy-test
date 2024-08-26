class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show update destroy ]

  # GET /movies
  def index
    @movies = Movie.includes(:genres).all

    render json: @movies.as_json(include: :genres)
  end

  # GET /movies/1
  def show
    render json: @movie.as_json(include: :genres)
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      if params[:genre_ids]
        @movie.genres << Genre.where(id: params[:genre_ids])
      end

      render json: @movie.as_json(include: :genres), status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      if params[:genre_ids]
        @movie.genres = Genre.where(id: params[:genre_ids])
      end

      render json: @movie.as_json(include: :genres), status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy!
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :tagline, :overview, :homepage, :runtime, :budget, :revenue, :status, :release_date, :score, genre_ids: [])
    end
end
