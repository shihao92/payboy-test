class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :tagline
      t.text :overview
      t.string :homepage
      t.integer :runtime
      t.string :budget
      t.string :revenue
      t.integer :status
      t.timestamp :release_date
      t.string :score

      t.timestamps
    end
  end
end
