class StatsController < ApplicationController
  def index
    @all_films = Film.find(:all)
    @total = @all_films.length
    
    #TODO: Clean this up
    @noimdb=[]
    @all_films.each do |t|
      @noimdb << t.imdb_id if t.imdb_id.empty?
    end
    @without_imdb = @noimdb.length
  end
end
