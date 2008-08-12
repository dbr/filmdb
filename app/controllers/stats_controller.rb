class StatsController < ApplicationController
  def index
    @total = Film.find(:all).length
    @without_imdb = Film.no_imdb.length
    @per_complete = 100 - ((@without_imdb / @total.to_f) * 100).round(2)
  end
end
