class Film < ActiveRecord::Migration
  def self.up
    change_column :films, :title, :string
    change_column :films, :imdb_id, :string
    add_index :films, :imdb_id
  end

  def self.down
    change_column :films, :title, :text
    change_column :films, :imdb_id, :text
  end
end
