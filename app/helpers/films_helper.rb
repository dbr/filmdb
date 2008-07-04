module FilmsHelper
  def make_imdb_link(imdb_id)
    if imdb_id != ""
      return link_to("IMDB", "http://www.imdb.com/title/%s/" % imdb_id)
    else
      return "N/a"
    end
  end
end
