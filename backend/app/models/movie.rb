class Movie < ApplicationRecord
  has_and_belongs_to_many :genres
  has_one_base64_attached :photo

  enum status: {
    rumored: 0,
    planned: 1,
    in_production: 2,
    post_production: 3,
    released: 4,
    cancelled: 5
  }

  validates :title, presence: true, uniqueness: true

  def photo_url
    Rails.application.routes.url_helpers.rails_blob_url(photo, only_path: true) if photo.attached?
  end
end
