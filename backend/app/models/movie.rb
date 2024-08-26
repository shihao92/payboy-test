class Movie < ApplicationRecord
  has_and_belongs_to_many :genres

  enum status: {
    rumored: 0,
    planned: 1,
    in_production: 2,
    post_production: 3,
    released: 4,
    cancelled: 5
  }
end
