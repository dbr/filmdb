class CreateFilms < ActiveRecord::Migration
  def self.up
    create_table :films do |t|
      t.text :title
      t.text :review
      t.text :imdb_id

      t.timestamps
    end
  end

  def self.down
    drop_table :films
  end
end
