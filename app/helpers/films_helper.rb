module FilmsHelper
  def make_imdb_link(imdb_id)
    if imdb_id != ""
      return link_to("IMDB", "http://www.imdb.com/title/%s/" % imdb_id)
    else
      return "N/a"
    end
  end
  
  def imdb_id_completion
    100 - ((num_without_imdb / num_all.to_f) * 100).round(2)
  end
  
  def num_without_imdb
    Film.no_imdb.length
  end
  def num_all
    Film.find(:all).length
  end
end
