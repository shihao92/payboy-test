class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[ show update destroy ]

  # GET /movies
  def index
    @movies = filter_movies(Movie.order(created_at: :desc).includes(:genres).page(params[:page]).per(params[:per_page] || 10))
    render json: {
      movies: @movies.as_json(
        only: [:id, :title, :status, :release_date, :score, :director],
        include: {
          genres: {
            only: [:name]
          },
        },
        methods: :photo_url
      ),
      meta: pagination_meta(@movies)
    }
  end

  # GET /movies/1
  def show
    render json: @movie.as_json(include: :genres)
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      if params[:movie][:photo_data].present?
        @movie.photo.attach(decode_base64_image(params[:movie][:photo_data]))
      end

      if params[:genre_ids]
        @movie.genres << Genre.where(id: params[:genre_ids])
      end

      render json: @movie.as_json(include: :genres, methods: :photo_url), status: :created, location: @movie
    else
      render json: { errors: format_errors(@movie.errors) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      if params[:movie][:photo_data].present?
        @movie.photo.attach(decode_base64_image(params[:movie][:photo_data]))
      end

      if params[:genre_ids]
        @movie.genres = Genre.where(id: params[:genre_ids])
      end
      
      render json: @movie.as_json(include: :genres), status: :created, location: @movie
    else
      render json: { errors: format_errors(@movie.errors) }, status: :unprocessable_entity
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
    params.require(:movie).permit(:title, :tagline, :overview, :homepage, :runtime, :budget, :revenue, :status, :release_date, :score, :director, genre_ids: [])
  end

  def filter_movies(movies)
    filters = params.slice(:title, :tagline, :overview, :homepage, :director)

    filters.each do |key, value|
      movies = movies.where("#{key} ILIKE ?", "%#{value}%") if value.present?
    end

    movies
  end
end
