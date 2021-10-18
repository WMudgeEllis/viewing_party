class AddMovieIdtoShowings < ActiveRecord::Migration[5.2]
  def change
    add_column :showings, :movie_id, :integer
  end
end
