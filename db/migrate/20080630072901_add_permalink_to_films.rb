class AddPermalinkToFilms < ActiveRecord::Migration
  def self.up
    add_column :films, :permalink, :string
  end

  def self.down
    remove :films, :permalink
  end
end
