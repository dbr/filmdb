class Film < ActiveRecord::Base
  has_permalink :title 
  def to_param
    permalink
  end
  
  def imdb_link
    if imdb_id.nil?
      return
    else
      return "http://www.imdb.com/title/%s/" % (imdb_id)
    end
  end
  
  def self.search(search)
    if search
      search.strip!
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
