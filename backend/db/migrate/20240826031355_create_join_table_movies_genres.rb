class CreateJoinTableMoviesGenres < ActiveRecord::Migration[7.2]
  def change
    create_join_table :movies, :genres do |t|
      t.index :movie_id
      t.index :genre_id
    end
  end
end
