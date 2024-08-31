class MovieSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :status, :release_date, :score

  has_many :genres, serializer: GenreSerializer
end
