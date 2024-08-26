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
      params.require(:movie).permit(:title, :tagline, :overview, :homepage, :runtime, :budget, :revenue, :status, :release_date, :score, genre_ids: [])
    end

    def format_errors(errors)
      errors.messages.transform_values { |messages| messages.join(', ') }
    end

    def decode_base64_image(base64_image)
      content_type = base64_image[%r{data:(.*?);base64}, 1]
      encoded_image = base64_image.sub(%r{^data:.*;base64,}, '')
      decoded_image = Base64.decode64(encoded_image)
      {
        io: StringIO.new(decoded_image),
        filename: "upload-#{Time.now.to_i}.#{content_type.split('/').last}",
        content_type: content_type
      }
    end
end
